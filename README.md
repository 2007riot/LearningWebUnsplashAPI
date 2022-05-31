# LearningWebUnsplashAPI

The project was built using SwiftUI and MVVM app architecture. The main goal - is to learn and practice how to work with the API in swift. Unsplash API was chosen because of its beautiful images and to practice how to convert data into an image.  

## Main Implementation
To fetch data from API were created two main functions:
```swift
func fetch()
func loadImage ()
```
fetch() - fetch the data from the API and with JSONDecoder can show the data in the UI

<img src="https://user-images.githubusercontent.com/73304608/171253846-e92bc9ea-b9cf-429b-81b2-1cfe65331000.png" width="277" height="600">

fetch() triggers when user submit text onto search bar.

```swift
.searchable(text: $apiResultFetcher.searchText, placement: .navigationBarDrawer)
        .onSubmit(of: .search, {
            
            apiResultFetcher.fetch()
        })
```


https://user-images.githubusercontent.com/73304608/171260280-009d9145-d8cb-49a6-997e-ff5bf02b3bfe.mp4




loadImage() load image from url (that is provided from fetch()) and creates UIImage from decoded data. To not load images again (when user is scrolling) - all images data caches in the app:

```swift
 var request = URLRequest(url: fetchURl, cachePolicy: .returnCacheDataElseLoad)
```

Displaying image in the UI

```swift
if imageLoader.image != nil {
            Image(uiImage: imageLoader.image!)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width * 0.90, height: imageSize)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
        } else if imageLoader.errorMessage != nil {
            Text(imageLoader.errorMessage!)
                .foregroundColor(.pink)
                .frame(width: UIScreen.main.bounds.width * 0.90, height: imageSize)
        } else {
            ProgressView()
                .frame(width: UIScreen.main.bounds.width * 0.90, height: imageSize)
        }

```

In order to practice more I implemented new iOS 15 AsyncImage
```swift
 if apiResult.urls?.full != nil {
                    AsyncImage(url: URL(string: apiResult.urls!.full!)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: imageSize)
                                .clipped()
                            //some error when image is loading
                        } else if phase.error != nil {
                            Text(phase.error?.localizedDescription ?? "error")
                                .foregroundColor(.pink)
                                .frame(width: imageSize, height: imageSize)
                            //loading image
                        } else {
                            ProgressView()
                                .frame(width: imageSize, height: imageSize)
                        }
                    }
                } else {
                    Color
                        .gray
                        .frame(height: imageSize)
                }
```

## Errors

To display networking errors in UI for users was created APIError
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
And we can see errors in the UI:

<img src="https://user-images.githubusercontent.com/73304608/171248068-5c55ea75-36e1-415c-94e9-be4eec65ebe7.png" width="277" height="600">   <img src="https://user-images.githubusercontent.com/73304608/171248208-de46439a-6c91-400a-83e1-abe0aa0c3099.png" width="277" height="600">



Main logic inspired by Karin Prater [amazing tutorials](https://www.youtube.com/watch?v=ggEcSzPbVr4&list=PLWHegwAgjOko-_H8MPHbPJbA24Gel2fg_&ab_channel=KarinPrater).

It was fun to work with Unsplash API and I learnt a lot by building this project. 



