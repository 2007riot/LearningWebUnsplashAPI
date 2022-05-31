//
//  APIResult.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 31/05/22.
//

import Foundation

struct APIResult: Codable, Identifiable, Hashable {
    
    let id: String?
    let description: String?
    let urls: URLs?
    let user: User
    let links: PhotoLinks?
    
    
    //MARK: default result for preview and testing purposes
    static func example1() -> APIResult {
        return APIResult(
            id: "eOLpJytrbsQ",
            description: "A man drinking a coffee.",
            urls: URLs.urlsExample(),
            user: User.userExample(), links: PhotoLinks.example())
        
        
    }
}
