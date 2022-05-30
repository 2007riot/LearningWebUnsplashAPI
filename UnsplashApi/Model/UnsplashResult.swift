//
//  SearchResult.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 18/05/22.
//

import Foundation
import SwiftUI

//{
//  "total": 133,
//  "total_pages": 7,
//  "results": [
//    {
//      "id": "eOLpJytrbsQ",
//      "created_at": "2014-11-18T14:35:36-05:00",
//      "width": 4000,
//      "height": 3000,
//      "color": "#A7A2A1",
//      "blur_hash": "LaLXMa9Fx[D%~q%MtQM|kDRjtRIU",
//      "likes": 286,
//      "liked_by_user": false,
//      "description": "A man drinking a coffee.",
//      "user": {
//        "id": "Ul0QVz12Goo",
//        "username": "ugmonk",
//        "name": "Jeff Sheldon",
//        "first_name": "Jeff",
//        "last_name": "Sheldon",
//        "instagram_username": "instantgrammer",
//        "twitter_username": "ugmonk",
//        "portfolio_url": "http://ugmonk.com/",
//        "profile_image": {
//          "small": "https://images.unsplash.com/profile-1441298803695-accd94000cac?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=32&w=32&s=7cfe3b93750cb0c93e2f7caec08b5a41",
//          "medium": "https://images.unsplash.com/profile-1441298803695-accd94000cac?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64&s=5a9dc749c43ce5bd60870b129a40902f",
//          "large": "https://images.unsplash.com/profile-1441298803695-accd94000cac?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=128&w=128&s=32085a077889586df88bfbe406692202"
//        },
//        "links": {
//          "self": "https://api.unsplash.com/users/ugmonk",
//          "html": "http://unsplash.com/@ugmonk",
//          "photos": "https://api.unsplash.com/users/ugmonk/photos",
//          "likes": "https://api.unsplash.com/users/ugmonk/likes"
//        }
//      },
//      "current_user_collections": [],
//      "urls": {
//        "raw": "https://images.unsplash.com/photo-1416339306562-f3d12fefd36f",
//        "full": "https://hd.unsplash.com/photo-1416339306562-f3d12fefd36f",
//        "regular": "https://images.unsplash.com/photo-1416339306562-f3d12fefd36f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&s=92f3e02f63678acc8416d044e189f515",
//        "small": "https://images.unsplash.com/photo-1416339306562-f3d12fefd36f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&s=263af33585f9d32af39d165b000845eb",
//        "thumb": "https://images.unsplash.com/photo-1416339306562-f3d12fefd36f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=8aae34cf35df31a592f0bef16e6342ef"
//      },
//      "links": {
//        "self": "https://api.unsplash.com/photos/eOLpJytrbsQ",
//        "html": "http://unsplash.com/photos/eOLpJytrbsQ",
//        "download": "http://unsplash.com/photos/eOLpJytrbsQ/download"
//      }
//    },
//    // more photos ...
//  ]
//}


struct UnsplashResult: Codable {
    
    internal init(total: Int, totalPages: Int, results: [APIResult]) {
        self.total = total
        self.totalPages = totalPages
        self.photoResults = results
    }
    
    
    // In order to run for each loop, need to comporm to identifable protocol
    
    
    let total: Int?
    let totalPages: Int?
    let photoResults: [APIResult]
    
    
    
    enum CodingKeys: String, CodingKey {
        
        case total
        case totalPages = "total_pages"
        case photoResults = "results"
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        total = try values.decode(Int.self, forKey: .total)
        totalPages = try values.decode(Int.self, forKey: .totalPages)
        photoResults = try values.decode([APIResult].self, forKey: .photoResults)
    }
    
    
    
}

struct APIResult: Codable, Identifiable, Hashable {
    
    let id: String?
    let description: String?
    let urls: URLs?
    let user: User
    
    
    
    //MARK: default result for preview and testing purposes
    static func example1() -> APIResult {
        return APIResult(
            id: "eOLpJytrbsQ",
            description: "A man drinking a coffee.",
            urls: URLs.urlsExample(),
            user: User.userExample())
        
        
    }
}

struct User: Codable, Identifiable, Hashable {
    
    internal init(id: String, name: String, username: String, portfoliURL: String?) {
        self.id = id
        self.name = name
        self.username = username
        self.portfoliURL = portfoliURL
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        username = try values.decode(String.self, forKey: .username)
        portfoliURL = try values.decodeIfPresent(String.self, forKey: .portfoliURL)
    }
    
    let id: String
    let name: String
    let username: String
    let portfoliURL: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case username
        case portfoliURL = "portfolio_url"
    }
    
    //MARK: default user for preview and testing purposes
    static func userExample() -> User {
        
        return User(
            id: "Ul0QVz12Goo",
            name: "Jeff Sheldon",
            username: "ugmonk",
            portfoliURL: "http://ugmonk.com/")
    }
}
struct URLs: Codable, Hashable {
    
    let small: String?
    let thumb: String?
    let regular: String?
    
    //MARK: default urls for preview and testing purposes
    static func urlsExample() -> URLs {
        return URLs(
            small: "https://images.unsplash.com/photo-1416339306562-f3d12fefd36f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&s=263af33585f9d32af39d165b000845eb",
            thumb: "https://images.unsplash.com/photo-1416339306562-f3d12fefd36f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=200&fit=max&s=8aae34cf35df31a592f0bef16e6342ef",
            regular: "https://images.unsplash.com/photo-1416339306562-f3d12fefd36f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&s=92f3e02f63678acc8416d044e189f515")
    }
    
}
