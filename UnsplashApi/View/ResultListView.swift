//
//  ResultListView.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import SwiftUI

struct ResultListView: View {
    
    @StateObject var apiResultFetcher = SearchResultFetcher()
    let apiResults: [SearchResult]
    var body: some View {
        NavigationView {
            List {
                ForEach(apiResults, id: \.self) { apiResult in
                    APIResultRow(apiresult: apiResult.results)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Unsplash")
            .searchable(text: $apiResultFetcher.searchText)
        }
        .onAppear() {
            //so we safe network data usage, but increase our phone memory with images of cats😹
            print("cache size: \(URLCache.shared.memoryCapacity / 1024) KB")
            //increase cache size to half of gigabyte
            URLCache.shared.memoryCapacity = 1024 * 1024 * 512
        }
    }
}

//struct ResultListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultListView(apiResults: Results())
//    }
//}
