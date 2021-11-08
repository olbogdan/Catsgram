//
//  LikeRequests.swift
//  Catsgram
//
//  Created by Oleksndr Bogdanov on 07.11.21.
//

import Foundation
import KituraContracts

struct AddLikeToPostRequest: APIRequest {
    typealias Response = Like

    var method: HTTPMethod { .POST }
    var path: String { "/likes" }
    var contentType: String { "application/json" }
    var additionalHeaders: [String: String] { [:] }
    var params: EmptyParams? { nil }
    var body: Data? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return try? encoder.encode(like)
    }

    private let like: Like

    init(postId: UUID) {
        like = Like(postId: postId)
    }

    func handle(rowResponse: Data) throws -> Like {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Response.self, from: rowResponse)
    }
}

struct DeleteLikeFromPostRequest: APIRequest {
    private let postId: UUID

    init(postId: UUID) {
        self.postId = postId
    }

    typealias Response = Void

    var method: HTTPMethod { .DELETE }
    var path: String { "/likes" }
    var contentType: String { "application/json" }
    var additionalHeaders: [String: String] { [:] }
    var body: Data? { nil }
    var params: LikeParams? {
        LikeParams(postId: postId.uuidString, createdByUser: currentUser?.id ?? "")
    }

    func handle(rowResponse: Data) throws {}
}
