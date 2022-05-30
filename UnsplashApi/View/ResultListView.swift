//
//  ResultListView.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import SwiftUI

struct ResultListView: View {
    
    //@StateObject var apiResultFetcher = SearchResultFetcher()
    let photoResults: [APIResults]
    //let searchResult: SearchResult
    var body: some View {
        NavigationView {
            List {
                ForEach(photoResults, id: \.self) { apiResult in
                    APIResultRow(apiresult: apiResult)
                }
//                ForEach(searchResult.photoResults, id: \.self) { apiResult in
//                    APIResultRow(apiresult: apiResult)
//                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Unsplash")
            //.searchable(text: $apiResultFetcher.searchText)
        }
        .onAppear() {
            //apiResultFetcher.fetchResult()
            //so we safe network data usage, but increase our phone memory with images 
            print("cache size: \(URLCache.shared.memoryCapacity / 1024) KB")
            //increase cache size to half of gigabyte
            URLCache.shared.memoryCapacity = 1024 * 1024 * 512
        }
    }
}

//struct ResultListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultListView()
//    }
//}
