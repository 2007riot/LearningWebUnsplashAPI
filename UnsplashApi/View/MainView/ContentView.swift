//
//  ContentView.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var apiResultFetcher = SearchResultFetcher()
    var body: some View {
        if apiResultFetcher.isLoading {
            ProgressView()
        } else if apiResultFetcher.errorMessage != nil {
            ErrorMainView(apiResultFetcher: apiResultFetcher)
        } else {
            ResultListView(photoResults: apiResultFetcher.apiResults)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
