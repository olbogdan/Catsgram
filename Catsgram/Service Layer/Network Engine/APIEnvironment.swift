//
//  APIEnvironment.swift
//  Catsgram
//
//  Created by Oleksndr Bogdanov on 21.10.21.
//

import Foundation

struct APIEnvironment {
    var baseUrl: URL
}

extension APIEnvironment {
    static let prod = APIEnvironment(baseUrl: URL(string: "https/olcatgram.com/api/v1")!)
    static let local = APIEnvironment(baseUrl: URL(string: "http://localhost:8080/api/v1")!)
}
