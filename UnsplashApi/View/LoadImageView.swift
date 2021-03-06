//
//  LoadImageView.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import SwiftUI

struct LoadImageView: View {
    
    @StateObject var imageLoader: ImageLoader
    let imageSize: CGFloat = 300
    
    // creating data object from custom initializer and giving it a right url
    init(url: String?) {
        self._imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        VStack (alignment: .leading) {
        if imageLoader.image != nil {
            Image(uiImage: imageLoader.image!)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width * 0.90, height: imageSize)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
        } else if imageLoader.errorMessage != nil {
            Text(imageLoader.errorMessage!)
                .foregroundColor(.pink)
                .frame(width: UIScreen.main.bounds.width * 0.90, height: imageSize)
        } else {
            ProgressView()
                .frame(width: UIScreen.main.bounds.width * 0.90, height: imageSize)
        }
        }
        // fetching starts when view actually appears
        .onAppear() {
            imageLoader.searchImages()
        }
    }
}

struct LoadImageView_Previews: PreviewProvider {
    static var previews: some View {
        LoadImageView(url: nil)
    }
}
