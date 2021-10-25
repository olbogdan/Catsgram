//
//  Post.swift
//  Catsgram
//
//  Created by Oleksndr Bogdanov on 21.10.21.
//

import Foundation
import UIKit

struct Post : Codable, Identifiable {
    var id: UUID?
    var caption: String
    var createdAt: Date
    var createdByUser: String

    init(id: UUID? = nil, caption: String, createdAt: Date = Date(), createdBy: String = currentUser?.id ?? "") {
        self.id = id
        self.caption = caption
        self.createdAt = createdAt
        self.createdByUser = createdBy
    }
}
