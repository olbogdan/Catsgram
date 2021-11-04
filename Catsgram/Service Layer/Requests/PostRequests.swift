import Foundation

struct GetAllPostsRequest: APIRequest {
    typealias Response = [Post]

    var method: HTTPMethod { .GET }
    var path: String { "/posts" }
    var body: Data? { nil }
    var contentType: String { "application/json" }
    var params: EmptyParams? { nil }
    var additionalHeaders: [String: String] { [:] }

    func handle(rowResponse: Data) throws -> [Post] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Response.self, from: rowResponse)
    }
}

struct CreateNewPostRequest: APIRequest, Codable {
    typealias Response = Post

    let post: Post
    var contentType: String { "application/json" }
    var method: HTTPMethod { .POST }
    var path: String { "/posts" }
    var params: EmptyParams? { nil }
    var body: Data? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return try? encoder.encode(post)
    }
    var additionalHeaders: [String: String] { [:] }

    init(caption: String) {
        self.post = Post(caption: caption)
    }

    func handle(rowResponse: Data) throws -> Post {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Response.self, from: rowResponse)
    }
}
