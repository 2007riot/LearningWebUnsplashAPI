//
//  SearchResultFetcher.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 18/05/22.
//

import Foundation
import SwiftUI

class SearchResultFetcher: ObservableObject {
    
    
    init() {}
    var token = "aRSpEUSP492gx0Ui0q7qeRAH56ZTNZGlo0-Or3TivBE"
    
    @Published var apiResults: [APIResult] = []
    @Published var searchText: String = "water"
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var image: UIImage? = nil
    
    
    
    func fetch() {
        
        //the fetching starts, it's loading
        isLoading = true
        //when loading is started need to reset error message
        errorMessage = nil
        apiResults = []
        //create URL (optional)
        let url = URL(string: "https://api.unsplash.com/search/photos?query=\(searchText)")!
        
        var request = URLRequest(url: url)
        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    self.isLoading = false
                    do {
                        let unsplashResult = try decoder.decode(UnsplashResult.self, from: data)
                        
                        self.apiResults.append(contentsOf: unsplashResult.photoResults)
                        print(data)
                        print(unsplashResult.photoResults.count)
                    }
                    
                    catch {
                        self .errorMessage = error.localizedDescription
                        print(error)
                    }
                    
                }
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    self.errorMessage = APIError.badResponse(statucCode: response.statusCode).localizedDescription
                }
                
                
            }
            
        }
        task.resume()
        
    }
     
}
