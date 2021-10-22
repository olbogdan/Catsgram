//
//  JsonData.swift
//  CatsgramTests
//
//  Created by Oleksndr Bogdanov on 21.10.21.
//

import Foundation

enum JsonData {
    static let goodFeed = """
 [
    {
        "photoUrl": "photos/image1.jpg",
        "createdAt": "2021-10-21T12:00:00Z",
        "caption": "Living with my cat! #seam #little"
    },
    {
        "photoUrl": "photos/image2.jpg",
        "createdAt": "2021-10-20T12:00:00Z",
        "caption": "Eating with my cat! #food #lunch"
    },
    {
        "photoUrl": "photos/image3.jpg",
        "createdAt": "2021-10-19T12:00:00Z",
        "caption": "Sleeping with my cat.. Good night 😴"
    }
 ]
 """

    static let badJson = """
 [
    {
        "badJson": "",
    }
 ]
 """
}
