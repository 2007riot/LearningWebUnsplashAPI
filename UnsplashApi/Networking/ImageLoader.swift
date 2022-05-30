//
//  ImageLoader.swift
//  UnsplashApi
//
//  Created by Galina Aleksandrova on 26/05/22.
//

import Foundation
import UIKit

class ImageLoader: ObservableObject {

    internal init(url: String?) {
        self.url = url
    }

    @Published var image: UIImage? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false

    let url: String?
    let token = "aRSpEUSP492gx0Ui0q7qeRAH56ZTNZGlo0-Or3TivBE"

    func searchImages () {

        //checking if there is an image already or we're already loading, only in that case we run, so don't need to fetch it again
        guard image == nil, !isLoading else {
            return
        }
        guard let url = url, let fetchURl = URL(string: url) else {
            errorMessage = APIError.badURL.localizedDescription
            return
        }

        isLoading = true
        errorMessage = nil


        //
        //        //working with our key, sometimes it can be called not client-ID, need to check in documentation
        //        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")

        // create request and not load image again on scrolling need to cache them
        var request = URLRequest(url: fetchURl, cachePolicy: .returnCacheDataElseLoad)

        request.httpMethod = "GET"

        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in

            DispatchQueue.main.async {

                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    self?.errorMessage = APIError.badResponse(statucCode: response.statusCode).localizedDescription
                } else if let data = data, let image = UIImage(data: data) {
                    self?.image = image
                } else {
                    self?.errorMessage = APIError.unknown.localizedDescription
                }
            }
        }
        task.resume()

    }
}
