//
//  PhotoLinks.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 31/05/22.
//

import Foundation

struct PhotoLinks: Codable, Hashable {
    
    let original: String
    let download: String
    
    internal init(original: String, download: String) {
        self.original = original
        self.download = download
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        original = try values.decode(String.self, forKey: .original)
        download = try values.decode(String.self, forKey: .download)
    }
    
    
    
    enum CodingKeys: String, CodingKey {
        
        case original = "html"
        case download
    }
    
    // MARK: default links for preview and testing purposes
    static func example() -> PhotoLinks {
        PhotoLinks(original: "https://api.unsplash.com/photos/eOLpJytrbsQ",
              download: "http://unsplash.com/photos/eOLpJytrbsQ/download")
    }
}
