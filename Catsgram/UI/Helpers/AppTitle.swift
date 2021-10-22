//
//  AppTitle.swift
//  Catsgram
//
//  Created by Oleksndr Bogdanov on 22.10.21.
//

import SwiftUI

struct AppTitle: View {
    var body: some View {
        Text("petstagram")
            .font(Font.custom("CoolStoryregular", size: 48))
    }
}

struct AppTitle_Preview: PreviewProvider {
    static var previews: some View {
        AppTitle()
            .previewLayout(.sizeThatFits)
    }
}
