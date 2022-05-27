//
//  APIService.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import Foundation

struct APIService {
    
    func fetchAPIResults(url: URL?, completion: @escaping(Result<[APIResult], APIError>) -> Void) {
        
        guard let url = url else {
           let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        // task always run on the background thread
        // because working with @escaping closure, don't need unowned self
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // catching url error
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
                // catching badresponse error, 200...299 I am checking statuc code, if it's not in the range 200...299, so there is some mistake
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statucCode: response.statusCode)))
                // no error found
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let cats = try decoder.decode([APIResult].self, from: data)
                    
                    completion(Result.success(cats))
                    
                    
                    
                } catch {
                   // catch an error bad parsing (decoding json)
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
            
        }
        
        task.resume()
        
    }
    
    
    
}
