//
//  APIClientTests.swift
//  CatsgramTests
//
//  Created by Oleksndr Bogdanov on 22.10.21.
//

@testable import Catsgram
import Combine
import Swifter
import XCTest

class APIClientTests: XCTestCase {
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
        server.GET["api/v1/posts"] = { _ in HttpResponse.ok(.text(JsonData.goodFeed)) }

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
}
