//
//  SearchResult.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 18/05/22.
//

import Foundation
import SwiftUI

struct UnsplashResult: Codable {
    
    let total: Int?
    let totalPages: Int?
    let photoResults: [APIResult]
    
    internal init(total: Int, totalPages: Int, results: [APIResult]) {
        self.total = total
        self.totalPages = totalPages
        self.photoResults = results
    }
    
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
