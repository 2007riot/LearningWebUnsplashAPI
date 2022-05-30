//
//  ImageDetailView.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 30/05/22.
//

import SwiftUI

struct ImageDetailView: View {
    
    let imageSize: CGFloat = 300
    let apiResult: APIResult
    var body: some View {
        
            VStack (alignment: .leading, spacing: 30) {
                HStack {
                    Spacer()
                    
                    if apiResult.urls?.thumb != nil {
                        AsyncImage(url: URL(string: apiResult.urls!.thumb!)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: imageSize)
                                .clipped()
                            //some error when image is loading
                        } else if phase.error != nil {
                            Text(phase.error?.localizedDescription ?? "error")
                                .foregroundColor(.pink)
                                .frame(width: imageSize, height: imageSize)
                            //loading image
                        } else {
                            ProgressView()
                                .frame(width: imageSize, height: imageSize)
                        }
                    }
                } else {
                    Color
                        .gray
                        .frame(height: imageSize)
                }
                    
                    Spacer()
                    
                }
                VStack(alignment: .leading, spacing: 15) {
                    Text(apiResult.user.username)
                        .font(.headline)
                    if let portfolioURL = apiResult.user.portfoliURL {
                        Text(portfolioURL)
                            .font(.footnote)
                    }
                    
                    Spacer()
                    
                }
                .padding()
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }


struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(apiResult: APIResult.example1())
    }
}
