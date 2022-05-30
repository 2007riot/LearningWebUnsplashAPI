//
//  LoadImageView1.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 30/05/22.
//



import SwiftUI

struct LoadImageView1: View {
    
    @ObservedObject var searchResultFetcher: SearchResultFetcher
    let imageSize: CGFloat = 100
    
    
    var body: some View {
        Group {
            if searchResultFetcher.image != nil {
            Image(uiImage: searchResultFetcher.image!)
                .resizable()
                .scaledToFill()
                .frame(width: imageSize, height: imageSize)
                .clipped()
            
        } else if searchResultFetcher.errorMessage != nil {
            Text(searchResultFetcher.errorMessage!)
                .foregroundColor(.pink)
                .frame(width: imageSize, height: imageSize)
        } else {
            ProgressView()
                .frame(width: imageSize, height: imageSize)
        }
        }
        // fetching starts when view actually appears
        .onAppear() {
            searchResultFetcher.fetch()
        }
    }
}

struct LoadImageView1_Previews: PreviewProvider {
    static var previews: some View {
        LoadImageView(url: nil)
    }
}
