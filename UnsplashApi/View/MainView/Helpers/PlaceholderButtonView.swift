//
//  PlaceholderButtonView.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 31/05/22.
//

import SwiftUI

struct PlaceholderButtonView: View {
    let title: String
    var body: some View {
        Text(title)
    }
}

struct PlaceholderButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderButtonView(title: "cat")
    }
}
