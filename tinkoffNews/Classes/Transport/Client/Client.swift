//
//  Client.swift
//  tinkoffNews
//
//  Created by Маргарита on 14/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Клиент для выполнения запросов
class Client: ApiClient {
        
    static func request<Request>(
        with request: Request,
        completion: @escaping (Result<Request.Item, ApiClientError>) -> Void)
        where Request: Endpoint {
        
        do {
            if let httpRequest = try request.request() {
                let dataTask = URLSession.shared.dataTask(with: httpRequest) { (data, response, error) in
                    guard let data = data else { return }
                    do {
                        let pointOfInteres = try request.parse(response: data)
                        
                        DispatchQueue.main.async {
                            completion(pointOfInteres)
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(ApiClientError.invalidParseData(data)))
                        }
                    }
                }
                dataTask.resume()
            }
        } catch {
            DispatchQueue.main.async {
                completion(Result.failure(ApiClientError.invalidRequest))
            }
        }
    }
}
