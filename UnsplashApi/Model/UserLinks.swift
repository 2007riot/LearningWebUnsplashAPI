//
//  UserLinks.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 31/05/22.
//

import Foundation

struct UserLinks: Codable, Hashable {
    
    let userProfile: String
    let htmlProfile: String
    let allPhotos: String
    
    internal init(userProfile: String, htmlProfile: String, allPhotos: String) {
        self.userProfile = userProfile
        self.htmlProfile = htmlProfile
        self.allPhotos = allPhotos
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        userProfile = try values.decode(String.self, forKey: .userProfile)
        htmlProfile = try values.decode(String.self, forKey: .htmlProfile)
        allPhotos = try values.decode(String.self, forKey: .allPhotos)
        
    }
    
    enum CodingKeys: String, CodingKey {
        
        case userProfile = "self"
        case htmlProfile = "html"
        case allPhotos = "photos"
        
    }
    
    static func example () -> UserLinks {
        UserLinks(userProfile: "https://api.unsplash.com/users/ugmonk",
                  htmlProfile: "http://unsplash.com/@ugmonk",
                  allPhotos: "https://api.unsplash.com/users/ugmonk/photos")
    }
    
}

struct URLs: Codable, Hashable {
    
    let small: String?
    let thumb: String?
    let regular: String?
    let full: String?
    
    //MARK: default urls for preview and testing purposes
    static func urlsExample() -> URLs {
        URLs(
            small: "https://images.unsplash.com/photo-1416339306562-f3d12fefd36f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&s=263af33585f9d32af39d165b000845eb",
            thumb: "https://images.unsplash.com/photo-1416339306562-f3d12fefd36f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=8aae34cf35df31a592f0bef16e6342ef",
            regular: "https://images.unsplash.com/photo-1416339306562-f3d12fefd36f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&s=92f3e02f63678acc8416d044e189f515",
            full: "https://hd.unsplash.com/photo-1416339306562-f3d12fefd36f")
    }
    
}
