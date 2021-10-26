import Foundation

struct GetAllPostsRequest: APIRequest {
    typealias Response = [Post]

    var method: HTTPMethod { return .GET }
    var path: String { return "/posts" }
    var body: Data? { return nil }

    func handle(rowResponse: Data) throws -> [Post] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Response.self, from: rowResponse)
    }
}

struct CreateNewPostRequest: APIRequest, Codable {
    let post: Post

    init(caption: String) {
        self.post = Post(caption: caption)
    }

    typealias Response = Post

    var method: HTTPMethod { return .POST }
    var path: String { return "/posts" }
    var body: Data? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return try? encoder.encode(post)
    }

    func handle(rowResponse: Data) throws -> Post {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Response.self, from: rowResponse)
    }
}
