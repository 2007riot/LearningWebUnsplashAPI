//
//  User.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 31/05/22.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    
    let id: String
    let name: String
    let username: String
    let portfoliURL: String?
    let userLinks : UserLinks?
    
    internal init(id: String, name: String, username: String, portfoliURL: String?, userLinks: UserLinks) {
        self.id = id
        self.name = name
        self.username = username
        self.portfoliURL = portfoliURL
        self.userLinks = userLinks
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        username = try values.decode(String.self, forKey: .username)
        portfoliURL = try values.decodeIfPresent(String.self, forKey: .portfoliURL)
        userLinks = try values.decodeIfPresent(UserLinks.self, forKey: .userLinks)
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case username
        case portfoliURL = "portfolio_url"
        case userLinks = "links"
    }
    
    //MARK: default user for preview and testing purposes
    static func userExample() -> User {
        
        return User(
            id: "Ul0QVz12Goo",
            name: "Jeff Sheldon",
            username: "ugmonk",
            portfoliURL: "http://ugmonk.com/",
            userLinks: UserLinks.example())
    }
}
