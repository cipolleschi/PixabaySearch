//
//  NetworkProvider.swift
//  PixabaySearch
//
//  Created by Andras Pal on 13/04/2021.
//

import Foundation
import UIKit

class NetworkService {

    // [Riccardo] We can remove the shared property, we are moving away from the singleton approach
    static let shared = NetworkService()
    // this property should be private or fileprivate. It is a detail of how the download is handled.
    let dispatchGroup = DispatchGroup()

    private let apiKey = "13197033-03eec42c293d2323112b4cca6"
    
    private var baseUrlComponents: URLComponents {
        var urlComponents = URLComponents(string: "https://pixabay.com/api")!
        urlComponents.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        return urlComponents
    }
    
    //TODO: value must be between 3-200, limit it? | maybe more parameters later?
    func fetchImageData(query: String, amount: Int, completion: @escaping (Result<[ImageInfo], NetworkError>) -> Void ) {

      // [Riccardo] This function is doing a lot of things alltogether.
      // It is managing the dispatch group.
      // It is performing the network requests
      // It is handling the result.
      // I think we could achieve a better code readability if we split this function in other smaller ones.

      // Furthermore, why do you need the dispatchGroup? DispatchGroups are usually needed when we have to perform multiple downloads and we want wait for all of them to finish.
      // For example we have 10 image urls and we would like to download all of them before invoking the callback.
      // In our case, we are performing 1 network requests. We can remove the dispatch group completely.


        dispatchGroup.enter()

        var  urlComps = baseUrlComponents
        urlComps.queryItems? += [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "per_page", value: "\(amount)"),
        ]
        
        guard let url = urlComps.url else {
            // In this case, we already entered a process in the dispatch group (Line 29). However, we are never exiting it.
            // This makes everything wait for something that will never occur.
            completion(.failure(.missingUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                // Same issue as above: you have to exit every time you are about to call the completion.
                completion(.failure(.apiError(error)))
                // In case of an error, can I reach this line? Shouldn't we return here?
            }
            
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                200...299 ~= response.statusCode
            else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let serverResponse = try JSONDecoder().decode(SearchResults<ImageInfo>.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(serverResponse.hits))
                    self.dispatchGroup.leave()
                }
            }
            catch let unsuccessfulQuery {
              // We can reach this point only in case we failed to decode the response.
              // The error returned is not the right one because we are telling the user that the query is unsuccessful
              // but it may not be the case. For example, the query could be the right one, but we may have hit a rate limit.
                DispatchQueue.main.async {
                    completion(.failure(.other(unsuccessfulQuery)))
                    // we still miss leaving the dispatch group
                }
            }
        }.resume()
    }
}
