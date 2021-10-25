//
//  FeedCell.swift
//  Catsgram
//
//  Created by Oleksndr Bogdanov on 25.10.21.
//

import SwiftUI

struct FeedCell: View {
    var post: Post
    @State var postImage: UIImage? = nil
    private let placeholderImage = UIImage(systemName: "photo")!

    var body: some View {
        VStack {
            Image(uiImage: postImage ?? placeholderImage)
                .resizable()
                .scaledToFit()
                .cornerRadius(15)
                .overlay({
                    VStack(spacing: 10) {
                        Button {} label: {
                            Image(systemName: "heart.fill")
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
            CommentCell(post: post)
        }
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var previews: some View {
        let post = Post(caption: "Play with me, I'm your best friend, isn't it?", createdAt: Date(), createdBy: "SashaKot")
        return Group {
            FeedCell(post: post)
            FeedCell(post: post, postImage: UIImage(named: "1")!)
        }
        .previewLayout(.sizeThatFits)
    }
}
