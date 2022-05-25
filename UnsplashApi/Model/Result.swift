//
//  Result.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 18/05/22.
//

import Foundation
import SwiftUI

struct Results: Codable {
    var total: Int
    var results: [Result]
}

struct Result: Codable {
    var id: String
    var description: String?
    var urls: URLs
    var user: User
}

struct User: Codable {
    var name: String
}
struct URLs: Codable {
    var small: String
}
