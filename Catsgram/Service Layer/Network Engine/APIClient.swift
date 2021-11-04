//
//  APIClient.swift
//  Catsgram
//
//  Created by Oleksndr Bogdanov on 21.10.21.
//

import Combine
import Foundation
import KituraContracts
import CoreMedia

enum APIError: Error {
    case requestFailed(Int)
    case postProcessingFailed(Error?)
    case urlProcessingFailed
}

struct APIClient {
    let session: URLSession
    let environment: APIEnvironment

    init(session: URLSession = .shared, environment: APIEnvironment = .prod) {
        self.session = session
        self.environment = environment
    }

    func publisherForRequest<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, Error> {
        var url = environment.baseUrl.appendingPathComponent(request.path)
        var urlRequest = URLRequest(url: url)

        if let params = request.params {
            let failureResult: Fail<T.Response, Error> = Fail(error: APIError.urlProcessingFailed)
            guard let queryItems: [URLQueryItem] = try? QueryEncoder().encode(params),
                  var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            else {
                return failureResult.eraseToAnyPublisher()
            }

            components.queryItems = queryItems
            guard let newUrl = components.url else {
                return failureResult.eraseToAnyPublisher()
            }
            url = newUrl
        }

        urlRequest = URLRequest(url: url)
        urlRequest.addValue(request.contentType, forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        request.additionalHeaders.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }

        let publisher = session.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200 ..< 300 ~= httpResponse.statusCode else {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                    throw APIError.requestFailed(statusCode)
                }
                return data
            }
            .tryMap { data -> T.Response in
                try request.handle(rowResponse: data)
            }
            .tryCatch { error -> AnyPublisher<T.Response, APIError> in
                throw APIError.postProcessingFailed(error)
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()

        return publisher
    }
}
