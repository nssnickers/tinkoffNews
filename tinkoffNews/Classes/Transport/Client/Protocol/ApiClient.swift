//
//  ApiClient.swift
//  tinkoffNews
//
//  Created by Маргарита on 14/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

protocol ApiClient {
    
    /// Запрос к серверу
    ///
    /// - Parameters:
    ///   - request: запрос
    ///   - completion: блок выполнится по завершению запроса
    static func request<Request>(
        with request: Request,
        completion: @escaping (Result<Request.Item, ApiClientError>) -> Void
        ) where Request: Endpoint

}
