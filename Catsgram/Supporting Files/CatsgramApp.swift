//
//  CatsgramApp.swift
//  Catsgram
//
//  Created by Oleksndr Bogdanov on 21.10.21.
//

import Swifter
import SwiftUI

@main
struct CatsgramApp: App {
    let server: HttpServer = {
        let server = HttpServer()
        try? server.start(8081)
        server.POST["/api/v1/user"] = { _ in HttpResponse.ok(.text("""
        {
          "username": "username",
          "email": "email@example.com"
        }
        """)) }
        server.post["/api/v1/image"] = { _ in HttpResponse.ok(.text("")) }
        return server
    }()

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
