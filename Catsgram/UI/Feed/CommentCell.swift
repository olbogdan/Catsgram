//
//  CommentCell.swift
//  Catsgram
//
//  Created by Oleksndr Bogdanov on 25.10.21.
//

import SwiftUI

struct CommentCell: View {
    var post: Post

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 40)
                VStack(alignment: .leading) {
                    Text(post.createdByUser)
                        .font(.headline)
                        .foregroundColor(.accentGreen)
                    Text(
                        RelativeDateTimeFormatter().localizedString(for: post.createdAt, relativeTo: Date()))
                        .font(.caption)
                }
                Spacer()
            }
            Text(post.caption)
                .font(.body)
        }.padding()
    }
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        let date = Date().advanced(by: TimeInterval(exactly: -5 * 50)!)
        CommentCell(post: Post(id: UUID(), caption: "My little friend, good morning to you!", createdAt: date, createdBy: "Niko"))
    }
}
