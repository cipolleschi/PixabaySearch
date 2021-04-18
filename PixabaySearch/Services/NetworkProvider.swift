//
//  NetworkProvider.swift
//  PixabaySearch
//
//  Created by Andras Pal on 13/04/2021.
//

import Foundation
import UIKit

class NetworkService {
    
    static let shared = NetworkService()
    let dispatchGroup = DispatchGroup()

    private let apiKey = "13197033-03eec42c293d2323112b4cca6"
    
    private var baseUrlComponents: URLComponents {
        var urlComponents = URLComponents(string: "https://pixabay.com/api")!
        urlComponents.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        return urlComponents
    }
    
    //MARK: - Fetch Images
    //TODO: value must be between 3-200, limit it? | maybe more parameters later?
    func fetchImages(query: String, amount: Int, completion: @escaping (Result<[ImageInfo], NetworkError>) -> Void ) {
        
        dispatchGroup.enter()

        var  urlComps = baseUrlComponents
        urlComps.queryItems? += [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "per_page", value: "\(amount)"),
        ]
        
        guard let url = urlComps.url else {
            completion(.failure(.missingUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.apiError(error)))
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
                DispatchQueue.main.async {
                    completion(.failure(.other(unsuccessfulQuery)))
                }
            }
        }.resume()
    }
}
