//
//  FeedCell.swift
//  Catsgram
//
//  Created by Oleksndr Bogdanov on 25.10.21.
//

import Combine
import SwiftUI

struct FeedCell: View {
    var post: Post
    @State var postImage: UIImage? = nil
    @State private var subscriptions: Set<AnyCancellable> = []
    private let placeholderImage = UIImage(systemName: "photo")!

    var body: some View {
        VStack {
            Image(uiImage: postImage ?? placeholderImage)
                .resizable()
                .scaledToFit()
                .cornerRadius(15)
                .overlay({
                    VStack(spacing: 10) {
                        Button(action: toggleLike) {
                            let imageName = post.isLiked ?"heart.fill" : "heart"
                            Image(systemName: imageName)
                                .foregroundColor(Color.red)
                        }
                        Button {} label: {
                            Image(systemName: "bubble.right.fill")
                        }
                        Button {} label: {
                            Image(systemName: "arrowshape.turn.up.right.fill")
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                    .shadow(color: .white, radius: 3)
                }(), alignment: .bottomTrailing)
                .onAppear {
                    guard let imageId = post.id else {
                        return
                    }
                    let client = APIClient()
                    let request = DownloadImageRequest(imageId: imageId)
                    client.publisherForRequest(request)
                        .replaceError(with: placeholderImage)
                        .sink { image in
                            postImage = image
                        }
                        .store(in: &subscriptions)
                }
            CommentCell(post: post)
        }
        .buttonStyle(PlainButtonStyle())
    }

    private func toggleLike() {
        if post.isLiked {
            deleteLike()
        } else {
            addLike()
        }
    }

    private func addLike() {
        guard let postId = post.id else { fatalError() }
        let client = APIClient()
        let request = AddLikeToPostRequest(postId: postId)
        client.publisherForRequest(request)
            .sink(receiveCompletion: { result in
                if case .finished = result {
                    // TODO: update the post
                }
            }, receiveValue: { _ in })
            .store(in: &subscriptions)
    }

    private func deleteLike() {
        guard let postId = post.id else { fatalError() }
        let client = APIClient()
        let request = DeleteLikeFromPostRequest(postId: postId)
        client.publisherForRequest(request)
            .sink(receiveCompletion: { result in
                if case .finished = result {
                    // TODO: update the post
                }
            }, receiveValue: { _ in })
            .store(in: &subscriptions)
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        let post = Post(caption: "Play with me, I'm your best friend, isn't it?", createdAt: Date(), createdBy: "SashaKot")
        var likedPost = post
        likedPost.isLiked = true
        return Group {
            FeedCell(post: post)
            FeedCell(post: post, postImage: UIImage(named: "1")!)
            FeedCell(post: likedPost, postImage: UIImage(named: "1")!)
        }
        .previewLayout(.sizeThatFits)
    }
}
