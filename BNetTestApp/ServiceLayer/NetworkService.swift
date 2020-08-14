//
//  NetworkService.swift
//  BNetTestApp
//
//  Created by Ольга on 12.08.2020.
//  Copyright © 2020 Ольга. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func request(params: [String: String], completion: @escaping (Result<Data?, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    func request(params: [String : String], completion: @escaping (Result<Data?, Error>) -> Void) {
        
        guard let url = self.url(params: params).url else { return }
        var request = URLRequest(url: url)
        
        if let query = url.query {
            request.httpMethod = "POST"
            request.httpBody = query.data(using: .utf8)
            request.addValue(API.token, forHTTPHeaderField: "token");
        }
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Result<Data?, Error>) -> Void)  -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else {
                completion(.success(data))
            }
        }
    }
}
    
    private func url(params: [String: String]) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = API.scheme
        urlComponents.host = API.host
        urlComponents.path = API.path
        urlComponents.queryItems = params.map{ URLQueryItem(name: $0, value: $1) }
        return urlComponents
    }
}
