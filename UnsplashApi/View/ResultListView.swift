//
//  ResultListView.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import SwiftUI

struct ResultListView: View {
    
    let apiResults : [APIResult]
    
    
    var body: some View {
        
        if apiResults.isEmpty {
            
            VStack (spacing: 20) {
                
                Spacer()
                
                Text("📸")
                    .font(.system(size: 100))
                
                Text ("Start from searching an image")
                
                Spacer()
                
            }
        } else {
            ScrollView {
                
            ForEach(apiResults, id: \.self) { apiResult in
                
                APIResultRow(apiresult: apiResult)
                    
//                NavigationLink {
//                    ImageDetailView(apiResult: apiResult)
//                } label: {
//                    APIResultRow(apiresult: apiResult)
//                }
            }
        }
        .onAppear() {
            
            //so we safe network data usage, but increase our phone memory with images
            
            //increase cache size to half of gigabyte
            URLCache.shared.memoryCapacity = 1024 * 1024 * 512
            print("cache size: \(URLCache.shared.memoryCapacity / 1024) KB")
        }
        }
    }
}

struct ResultListView_Previews: PreviewProvider {
    static var previews: some View {
        ResultListView(apiResults: [APIResult.example1()])
    }
}
