//
//  PostRequestTests.swift
//  CatsgramTests
//
//  Created by Oleksndr Bogdanov on 21.10.21.
//

import XCTest
import Swifter
import Combine
@testable import Catsgram

class PostRequestTests : XCTestCase {
    var server = HttpServer()

    override func setUpWithError() throws {
        server.notFoundHandler = { [weak self] request in
            let attachment = XCTAttachment(string: "\(request.method) on \(request.path) requested, but not found")
            attachment.name = "Unhandled API path requested"
            attachment.lifetime = .keepAlways
            self?.add(attachment)
            return HttpResponse.notFound()

        }

        do {
            try server.start()
        } catch {
            XCTFail("Could not start Swifter")
        }
    }

    override func tearDownWithError() throws {
        server.stop()
    }

    func testPublisherForRequest() {
        server.GET["api/v1/posts"] = { _ in HttpResponse.ok(.text(JsonData.goodFeed))}

        let request = PostRequest()
        let client = APIClient(environment: .local)

        var networkResult: Subscribers.Completion<Error>?
        var fetchedPosts: [Post]?

        let networkExpectation = expectation(description: "Network request")

        let cancellable = client.publisherForRequest(request)
            .sink { result in
                networkResult = result
                XCTAssertTrue(Thread.current.isMainThread, "Network completion called on background thread")
                networkExpectation.fulfill()
            } receiveValue: { posts in
                fetchedPosts = posts
            }


        wait(for: [networkExpectation], timeout: 3)
        cancellable.cancel()

        guard let result = networkResult else {
            XCTFail("No result from network request")
            return
        }
        switch result {
            case .finished:
                XCTAssertEqual(fetchedPosts?.count, 3)
            case .failure(let error):
                XCTFail(error.localizedDescription)
        }
    }

    func testHandleWithGoodData() throws {
        let data = JsonData.goodFeed.data(using: .utf8)!

        let request = PostRequest()
        do {
            let result = try request.handle(rowResponse: data)
            XCTAssertEqual(result.count, 3)
        } catch let decodingError  as DecodingError {
            XCTFail((decodingError as CustomDebugStringConvertible).debugDescription)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testHandleWithBadData() {
        let data = JsonData.badJson.data(using: .utf8)!
        let request = PostRequest()
        XCTAssertThrowsError(try request.handle(rowResponse: data)) { error in
            XCTAssertTrue(error is DecodingError)
        }
    }
}
