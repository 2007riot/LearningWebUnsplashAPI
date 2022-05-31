# LearningWebUnsplashAPI

The UI was written in SwiftUI. The main goal of this project - is to learn how work with the API in swift. Unsplash API was chosen because of beautiful pictures and in order to practise how to convert data into image. 

To fetch data from API was created two main functions:
```swift
func fetch()
func searchImages ()
```
fetch() - fetch all the data from the API and searchImages() creates UIImage from decoded data.

To display networking errors in UI for users was created APIError enum 
```swift
enum APIError: Error, CustomStringConvertible {
    case badURL 
    case badResponse(statucCode: Int) 
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
```


Inspired by Karin Prater [tutorial](https://www.youtube.com/watch?v=ggEcSzPbVr4&list=PLWHegwAgjOko-_H8MPHbPJbA24Gel2fg_&ab_channel=KarinPrater).




