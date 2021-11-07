//
//  Like.swift
//  Catsgram
//
//  Created by Oleksndr Bogdanov on 07.11.21.
//

import Foundation

struct Like: Codable {
    var id: UUID?
    var postId: UUID
    var cratedByUser: String
    var createdAt: Date

    internal init(id: UUID? = nil, postId: UUID, cratedByUser: String = currentUser?.id ?? "", createdAt: Date = Date()) {
        self.id = id
        self.postId = postId
        self.cratedByUser = cratedByUser
        self.createdAt = createdAt
    }
}
