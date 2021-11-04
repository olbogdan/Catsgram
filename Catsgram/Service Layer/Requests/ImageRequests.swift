import Foundation
import UIKit

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

    var additionalHeaders: [String: String] { ["Slug": "\(imageId.uuidString).jpg"] }

    init(imageId: UUID, imageData: Data) {
        self.imageId = imageId
        self.imageData = imageData
    }

    func handle(rowResponse: Data) throws {}
}

struct DownloadImageRequest: APIRequest {
    typealias Response = UIImage

    let imageId: UUID

    var method: HTTPMethod { .GET }
    var path: String { "/image/\(imageId.uuidString).jpg" }
    var contentType: String { "image/jpeg" }
    var additionalHeaders: [String: String] { [:] }
    var body: Data? { nil }
    var params: EmptyParams? { nil }

    init(imageId: UUID) {
        self.imageId = imageId
    }

    func handle(rowResponse: Data) throws -> UIImage {
        guard let image = UIImage(data: rowResponse) else {
            throw APIError.postProcessingFailed(nil)
        }
        return image
    }
}
