//
//  ContentView.swift
//  Catsgram
//
//  Created by Oleksndr Bogdanov on 21.10.21.
//

import Combine
import SwiftUI

struct ContentView: View {
//    var publisher: AnyCancellable = {
//        let client = APIClient()
//        let request = PostRequest()
//        return client.publisherForRequest(request)
//            .sink { result in
//                print(result)
//            } receiveValue: { newPosts in
//                print(newPosts)
//            }
//    }()
    @State var showingLogin = true

    let signInPublisher = NotificationCenter.default
        .publisher(for: .signInNotification)
        .receive(on: RunLoop.main)

    let signOutPublisher = NotificationCenter.default
        .publisher(for: .signOutNofication)
        .receive(on: RunLoop.main)

    var body: some View {
        Text("Hello, world!")
            .padding()
            .fullScreenCover(isPresented: $showingLogin) {
                LoginSignupView()
            }
            .onReceive(signInPublisher) { _ in
                showingLogin = false
            }
            .onReceive(signOutPublisher) { _ in
                showingLogin = true
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
