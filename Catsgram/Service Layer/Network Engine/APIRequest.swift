//
//  APIRequest.swift
//  Catsgram
//
//  Created by Oleksndr Bogdanov on 21.10.21.
//

import Foundation
import KituraContracts

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

struct EmptyParams: QueryParams {}

protocol APIRequest {
    associatedtype Response
    associatedtype QueryParamsType: QueryParams

    var method: HTTPMethod { get }
    var path: String { get }
    var body: Data? { get }
    var contentType: String { get }
    var params: QueryParamsType? { get }
    var additionalHeaders: [String: String] { get }

    func handle(rowResponse: Data) throws -> Response
}
