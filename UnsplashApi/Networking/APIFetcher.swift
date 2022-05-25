//
//  SearchObjectController.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 18/05/22.
//

import Foundation
import SwiftUI

class APIFetcher: ObservableObject {
    //shared version of the class, we only call these funcs through the shared protocol
    static let shared = APIFetcher()
    
    private init() {}
    
    var token = "aRSpEUSP492gx0Ui0q7qeRAH56ZTNZGlo0-Or3TivBE"
    @Published var results: [Result] = []
    @Published var searchText: String = ""
    
    func search()  {
        
        //creating a request
        //create url
        let url = URL(string: "https://api.unsplash.com/search/photos?page=1&query=\(searchText)") //it's an optional
        
        //create urlRequest
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"//because we get info from api
        
        //working with our key, sometimes it can be called not client-ID, need to check in documentation
        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")
        
        
        //starting getting info back
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                return
            }
            do {
                let res = try JSONDecoder().decode(Results.self, from: data)
                self.results.append(contentsOf: res.results)
            } catch {
                print(error.localizedDescription)

            }
        }
        
        task.resume()
    }
    
    
    
}
