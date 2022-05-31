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
    
    //MARK: default user for preview and testing purposes
    static func example () -> UserLinks {
        UserLinks(userProfile: "https://api.unsplash.com/users/ugmonk",
                  htmlProfile: "http://unsplash.com/@ugmonk",
                  allPhotos: "https://api.unsplash.com/users/ugmonk/photos")
    }
    
}


