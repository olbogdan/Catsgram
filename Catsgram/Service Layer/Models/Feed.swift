//
//  Feed.swift
//  Catsgram
//
//  Created by Oleksndr Bogdanov on 25.10.21.
//

import Combine
import Foundation

class Feed: ObservableObject {
    @Published var posts: [Post] = []
    @Published var loadError: Error?
    var signInSubscriber: AnyCancellable?
    var getPostSubscriber: AnyCancellable?

    init() {
        //load personalized feeds
        signInSubscriber = NotificationCenter.default.publisher(for: .signInNotification).sink { [weak self] _ in
            self?.loadFeed()
        }
        //load feeds
        loadFeed()
    }

    func loadFeed() {
        let client = APIClient()
        let request = GetAllPostsRequest()
        getPostSubscriber = client.publisherForRequest(request)
            .sink { [weak self] result in
                if case .failure(let error) = result {
                    self?.loadError = error
                }
            } receiveValue: { [weak self] newPosts in
                self?.posts = newPosts
            }
    }
}
