//
//  WebService.swift
//  Shaadi.com
//
//  Created by Yashashree on 21/11/20.
//

import Foundation


class WebService{
    class func fetchDetails(url: API_URL, completion: @escaping (Result<Data, NetworkError>) -> Void){
        guard let url = URL(string: url.url()) else{
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.error(message: error.localizedDescription)))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               (200...299).contains(httpResponse.statusCode) == false{
                completion(.failure(.badStatusCode(code: httpResponse.statusCode)))
                return
            }
            
            guard let detail = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(detail))
        }.resume()
    }
}
