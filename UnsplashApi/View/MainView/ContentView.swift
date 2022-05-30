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
        VStack {
            TextField("Search images", text: $apiResultFetcher.searchText)
                .onSubmit {
                    apiResultFetcher.fetch()
                }
                .padding()
                .textFieldStyle(.roundedBorder)
        Group {
        if apiResultFetcher.isLoading {
            ProgressView()
        } else if apiResultFetcher.errorMessage != nil {
            ErrorMainView(apiResultFetcher: apiResultFetcher)
        } else {
            ResultListView(photoResults: apiResultFetcher.apiResults)
        }
    }
        .onAppear() {
            apiResultFetcher.fetch()
        }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
