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
    // aRSpEUSP492gx0Ui0q7qeRAH56ZTNZGlo0-Or3TivBE
    var token = "aRSpEUSP492gx0Ui0q7qeRAH56ZTNZGlo0-Or3TivBE"
    
    @Published var apiResults: [APIResult] = []
    @Published var searchText: String = "spring"
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var image: UIImage? = nil
    
    
    
    func fetch() {
        
        //the fetching starts, it's loading
        isLoading = true
        //when loading is started need to reset error message
        errorMessage = nil
        
        //create URL (optional)
        let url = URL(string: "https://api.unsplash.com/search/photos?query=office")!
        
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
            
            
            
            //                if let error = error {
            //                    self.errorMessage = error.localizedDescription
            //                } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
            //                    self.errorMessage = APIError.badResponse(statucCode: response.statusCode).localizedDescription
            //                } else if let data = data  {
            //
            //                    let decoder = JSONDecoder()
            //
            //
            //                    do {
            //                        let unsplashResult = try decoder.decode(UnsplashResult.self, from: data)
            //
            //                        self.apiResults.append(contentsOf: unsplashResult.photoResults)
            //                        print(data)
            //                       // completion(Result.success(searchResult))
            //
            //
            //
            //                    } catch {
            //                       // catch an error bad parsing (decoding json)
            //                        self.errorMessage = APIError.parsing(error as? DecodingError).localizedDescription
            //                    }
            
            //                } else {
            //                    self.errorMessage = APIError.unknown.localizedDescription
            //                }
            
        }
        task.resume()
        //        let task1 = URLSession.shared.dataTask(with: request) { (data, response, error) in
        //
        //            guard let data = data else {
        //                return
        //            }
        //            do {
        //                let res = try JSONDecoder().decode(UnsplashResult.self, from: data)
        //                self.apiResults.append(contentsOf: res.photoResults)
        //            } catch {
        //                print(error.localizedDescription)
        //
        //            }
        //        }
        
        //        task.resume()
        
    }
    //    func fetchResult() {
    //        
    //        //the fetching starts, it's loading
    //        isLoading = true
    //        //when loading is started need to reset error message
    //        errorMessage = nil
    //        
    //        //create URL (optional)
    //        let url = URL(string: "https://api.unsplash.com/search/photos?page=1&query=\(searchText)")!
    //        
    //        var request = URLRequest(url: url)
    //        
    //        request.httpMethod = "GET"
    //        
    //        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")
    //        
    //        service.fetchAPIResults(url: url) { result in
    //            //to run on the main thread
    //            DispatchQueue.main.async {
    //                //when have result loading should stop
    //                self.isLoading = false
    //                
    //                // now check different result cases
    //                switch result {
    //                    case .failure(let error):
    //                        self.errorMessage = error.localizedDescription
    //                        print(error)
    //                    case .success(let searchResult):
    //                        self.apiResults = searchResult.photoResults
    //                }
    //            }
    //            
    //        }
    //        }
    
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
//if let error = error {
//    self.errorMessage = error.localizedDescription
//} else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
//    self.errorMessage = APIError.badResponse(statucCode: response.statusCode).localizedDescription
//}
