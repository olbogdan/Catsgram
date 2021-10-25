//
//  CreatePostView.swift
//  Catsgram
//
//  Created by Oleksndr Bogdanov on 25.10.21.
//

import SwiftUI

struct CreatePostView: View {
    @State var showNext = false
    @State var postImage = UIImage()

    var body: some View {
        NavigationView{
            VStack {
                TakePhotoView { image in
                    postImage = image
                    showNext = true
                }
                NavigationLink(destination: Image(uiImage: postImage), isActive: $showNext) {
                    EmptyView()
                }
            }
        }
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
    }
}
