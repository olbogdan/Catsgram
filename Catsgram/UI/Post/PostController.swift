import UIKit
import Combine

final class PostController: ObservableObject {
    @Published var isRunning = false
    @Published var postUploaded = false
    private var subscriptions: Set<AnyCancellable> = []

    func uploadPost(withDescription description: String, image: UIImage) {
        isRunning = true
        let client = APIClient()
        let request = CreateNewPostRequest(caption: description)
        client.publisherForRequest(request)
            .tryMap { post -> (UUID, Data) in
                guard let imageId = post.id, let imageData = image.jpegData(compressionQuality: 80) else {
                    throw APIError.postProcessingFailed(nil)
                }
                return (imageId, imageData)
            }
            .flatMap { (imageId, imageData) -> AnyPublisher<Void, Error> in
                let imageRequest = UploadImageRequest(imageId: imageId, imageData: imageData)
                let localClient = APIClient(environment: .local81)
                return client.publisherForRequest(imageRequest)
            }
            .sink(receiveCompletion: { completion in
                self.isRunning = false
                self.postUploaded = true
            }, receiveValue: { value in
            })
            .store(in: &subscriptions)
    }
}
