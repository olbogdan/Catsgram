import Foundation

struct UploadImageRequest: APIRequest {
    typealias Response = Void

    let imageId: UUID
    let imageData: Data
    var contentType: String { "image/jpeg" }
    var method: HTTPMethod { .POST }
    var path: String { "/image" }
    var params: EmptyParams? { nil }
    var body: Data? {
        imageData
    }
    var additionalHeaders: [String: String] { ["Slug":"\(imageId.uuidString).jpg"] }

    init(imageId: UUID, imageData: Data) {
        self.imageId = imageId
        self.imageData = imageData
    }

    func handle(rowResponse: Data) throws {}
}
