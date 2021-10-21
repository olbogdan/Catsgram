//
//  APIRequest.swift
//  Catsgram
//
//  Created by Oleksndr Bogdanov on 21.10.21.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
}

protocol APIRequest {
    associatedtype Response

    var method: HTTPMethod { get }
    var path: String { get }
    var body: Data? { get }

    func handle(rowResponse: Data) throws -> Response
}
