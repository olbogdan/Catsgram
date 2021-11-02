//
//  MainView.swift
//  Catsgram
//
//  Created by Oleksndr Bogdanov on 21.10.21.
//

import Combine
import SwiftUI

struct MainView: View {
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
    @State var showingPostView = false
    @StateObject var userData = UserData()

    let signInPublisher = NotificationCenter.default
        .publisher(for: .signInNotification)
        .receive(on: RunLoop.main)

    let signOutPublisher = NotificationCenter.default
        .publisher(for: .signOutNofication)
        .receive(on: RunLoop.main)

    var body: some View {
        TabView(selection: $userData.selectedTab) {
            FeedView()
                .tabItem {
                    Image("home")
                    Text("Home")
                }.tag(0)

            Text("")
                .sheet(isPresented: $showingPostView) {
                    CreatePostView()
                        .environmentObject(userData)
                }
                .tabItem {
                    Image("photo")
                    Text("Post")
                }
                .tag(1)

            Text("Tab Content 3")
                .tabItem {
                    Image("profile")
                    Text("Profile")
                }.tag(2)
        }
        .accentColor(.accentGreen)
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
        .onReceive(userData.$selectedTab) { selectedTab in
            showingPostView = (selectedTab == 1)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
