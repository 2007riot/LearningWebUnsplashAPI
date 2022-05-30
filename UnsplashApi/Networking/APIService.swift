////
////  APIService.swift
////  UnsplashApi
////
////  Created by Galina Aleksandrova on 26/05/22.
////
//
//import Foundation
//
////struct APIService {
////
////    func fetchAPIResults(url: URL?, completion: @escaping(Result<UnsplashResult, APIError>) -> Void) {
////
////        guard let url = url else {
////           let error = APIError.badURL
////            completion(Result.failure(error))
////            return
////        }
////
////        // task always run on the background thread
////        // because working with @escaping closure, don't need unowned self
////        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
////
////            // catching url error
////            if let error = error as? URLError {
////                completion(Result.failure(APIError.url(error)))
////                // catching badresponse error, 200...299 I am checking statuc code, if it's not in the range 200...299, so there is some mistake
////            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
////                completion(Result.failure(APIError.badResponse(statucCode: response.statusCode)))
////                // no error found
////            } else if let data = data {
////
////                let decoder = JSONDecoder()
////
////                do {
////                    let searchResult = try decoder.decode(UnsplashResult.self, from: data)
////
////                    completion(Result.success(searchResult))
////
////
////
////                } catch {
////                   // catch an error bad parsing (decoding json)
////                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
////                }
////            }
////
////        }
////
////        task.resume()
////
////    }
////
////
////
////}
//
//struct APIService {
//    
//    // to make it more reusable can change the func to work with generic type
//    func fetch<T: Decodable>(_ type: T.Type, url: URL?, completion: @escaping(Result<T, APIError>) -> Void) {
//        
//        guard let url = url else {
//           let error = APIError.badURL
//            completion(Result.failure(error))
//            return
//        }
//        
//        // task always run on the background thread
//        // because working with @escaping closure, don't need unowned self
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            
//            // catching url error
//            if let error = error as? URLError {
//                completion(Result.failure(APIError.url(error)))
//                // catching badresponse error, 200...299 I am checking statuc code, if it's not in the range 200...299, so there is some mistake
//            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
//                completion(Result.failure(APIError.badResponse(statucCode: response.statusCode)))
//                // no error found
//            } else if let data = data {
//                let decoder = JSONDecoder()
//                
//                do {
//                    let result = try decoder.decode(type.self, from: data)
//                    
//                    completion(Result.success(result))
//                    
//                    
//                    
//                } catch {
//                   // catch an error bad parsing (decoding json)
//                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
//                }
//            }
//            
//        }
//        
//        task.resume()
//        
//    }
//}
