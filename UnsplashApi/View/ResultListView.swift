//
//  ResultListView.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import SwiftUI

struct ResultListView: View {
   
    let photoResults: [APIResult]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(photoResults, id: \.self) { apiResult in
                    NavigationLink {
                        ImageDetailView(apiResult: apiResult)
                    } label: {
                        APIResultRow(apiresult: apiResult)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Unsplash")
            //.searchable(text: $apiResultFetcher.searchText)
        }
        .onAppear() {
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
