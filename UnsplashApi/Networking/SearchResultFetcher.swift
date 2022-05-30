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
   // aRSpEUSP492gx0Ui0q7qeRAH56ZTNZGlo0-Or3TivBE
    var token = "aRSpEUSP492gx0Ui0q7qeRAH56ZTNZGlo0-Or3TivBE"
    
    
    @Published var apiResults: [APIResults] = []
    @Published var searchText: String = "Spring"
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var image: UIImage? = nil
    
    let service = APIService()
    func fetch() {
        
        //the fetching starts, it's loading
        isLoading = true
        //when loading is started need to reset error message
        errorMessage = nil
        
        //create URL (optional)
        let url = URL(string: "https://api.unsplash.com/search/photos?page=1&query=\(searchText)")!
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    self.errorMessage = APIError.badResponse(statucCode: response.statusCode).localizedDescription
                } else if let data = data, let image = UIImage(data: data)  {
                    
                    let decoder = JSONDecoder()
                    self.image = image
                    
                    do {
                        let unsplashResult = try decoder.decode(UnsplashResult.self, from: data)
                        
                        self.apiResults.append(contentsOf: unsplashResult.photoResults)
                       // completion(Result.success(searchResult))
                        
                        
                        
                    } catch {
                       // catch an error bad parsing (decoding json)
                        self.errorMessage = APIError.parsing(error as? DecodingError).localizedDescription
                    }
                    
                } else {
                    self.errorMessage = APIError.unknown.localizedDescription
                }
            }
        }
        
        task.resume()
        
    }
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
                    case .success(let searchResult):
                        self.apiResults = searchResult.photoResults
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
