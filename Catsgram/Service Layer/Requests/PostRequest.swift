//
//  PostRequest.swift
//  Catsgram
//
//  Created by Oleksndr Bogdanov on 21.10.21.
//

import Foundation

struct PostRequest: APIRequest {
    typealias Response = [Post]
    var method: HTTPMethod { .GET }
    var path: String { "/posts" }
    var body: Data? { nil }

    func handle(rowResponse: Data) throws -> [Post] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Response.self, from: rowResponse)
    }
}
