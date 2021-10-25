//
//  Post.swift
//  Catsgram
//
//  Created by Oleksndr Bogdanov on 21.10.21.
//

import Foundation

struct Post : Codable, Identifiable {
    var id: UUID?
    var caption: String
    var createdAt: Date
}
