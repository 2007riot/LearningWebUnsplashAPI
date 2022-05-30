//
//  ErrorMainView.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import SwiftUI

struct ErrorMainView: View {
    @ObservedObject var apiResultFetcher: SearchResultFetcher
    var body: some View {
        VStack (spacing: 20) {
            Text("📸")
                .font(.system(size: 100))
            
            Text(apiResultFetcher.errorMessage ?? "")
            
            Button("Try again") {
                apiResultFetcher.fetch()
            }
        }
    }
}

struct ErrorMainView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMainView(apiResultFetcher: SearchResultFetcher())
    }
}
