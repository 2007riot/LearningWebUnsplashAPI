//
//  APIError.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case badURL //case when there's no url
    case badResponse(statucCode: Int) //statuc code error
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    
    var localizedDescription: String {
        //user feedback
        switch self {
        case .badURL, .parsing, .unknown:
            return "Sorry, something went wrong"
        case .badResponse(_):
            return "Sorry, the connection to the server failed"
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong"
            
        }
    }
    
    var description: String {
        //info for debugging
        switch self {
        case .unknown:
            return "unknown error"
        case .badURL:
            return "Invalid URL"
        case .url(let error):
            return error?.localizedDescription ?? "URL Session error"
        case .parsing(let error):
            return "parsing error \(error?.localizedDescription ?? "")"
        case .badResponse(statucCode: let statusCode):
            return "bad response with status code \(statusCode)"
        }
    }
}
