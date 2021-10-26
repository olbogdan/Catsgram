//
//  PostRequestTests.swift
//  CatsgramTests
//
//  Created by Oleksndr Bogdanov on 21.10.21.
//

import XCTest
@testable import Catsgram

class PostRequestTests : XCTestCase {

    func testHandleWithGoodData() throws {
        let data = JsonData.goodFeed.data(using: .utf8)!

        let request = GetAllPostsRequest()
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
        let request = GetAllPostsRequest()
        XCTAssertThrowsError(try request.handle(rowResponse: data)) { error in
            XCTAssertTrue(error is DecodingError)
        }
    }
}
