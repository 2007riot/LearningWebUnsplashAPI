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
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    let service = APIService()
    
    func fetchResult() {
        
        //the fetching starts, it's loading
        isLoading = true
        //when loading is started need to reset error message
        errorMessage = nil
        
        //create URL (optional)
        let url = URL(string: "https://api.unsplash.com/search/photos?page=1&query=\(searchText)")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")
        
        service.fetchAPIResults(url: url) { result in
            //to run on the main thread
            DispatchQueue.main.async {
                //when have result loading should stop
                self.isLoading = false
                
                // now check different result cases
                switch result {
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        print(error)
                    case .success(let apiResults):
                        self.apiResults = apiResults
                }
            }
            
        }
        }
        
        //starting getting info back
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            guard let data = data else {
//                return
//            }
//            do {
//                let res = try JSONDecoder().decode(Results.self, from: data)
//                self.results.append(contentsOf: res.results)
//            } catch {
//                print(error.localizedDescription)
//
//            }
//        }
        
//        task.resume()
        
        
    
    
}
