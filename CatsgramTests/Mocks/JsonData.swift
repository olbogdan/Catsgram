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
        "id": "4B08A288-3378-483F-ADA0-052298D64F3D",
        "createdAt": "2021-10-21T12:00:00Z",
        "caption": "Living with my cat! #seam #little"
    },
    {
        "id": "19888497-786F-4346-9F1D-EE317B319993",
        "createdAt": "2021-10-20T12:00:00Z",
        "caption": "Eating with my cat! #food #lunch"
    },
    {
        "id": "082D5914-37BB-46F1-A056-D68A4DF0D7AA",
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
