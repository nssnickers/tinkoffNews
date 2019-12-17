//
//  NewsEndpoint.swift
//  tinkoffNews
//
//  Created by Маргарита on 14/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Endpoint для запроса полной информации о новости
struct NewsEndpoint: Endpoint {
    
    // MARK: - Types
    
    typealias Item = FullNewsNetworkModel
    
    // MARK: - Private Properties
    
    private let urlSlug: String
    
    // MARK: - Initializers
    
    init(urlSlug: String) {
        self.urlSlug = urlSlug
    }
    
    // MARK: - Public Methods
    
    func request() throws -> URLRequest? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = Api.Url.scheme
        urlComponents.host = Api.Url.host
        urlComponents.path = Api.Url.path
        
        let queryParams = [
            URLQueryItem(name: "urlSlug", value: "\(urlSlug)")
        ]
        
        urlComponents.queryItems = queryParams
        
        guard var url = urlComponents.url else { return nil }
        let obtainNewsComponent = Api.NewsPath.obtainOne
        
        url.appendPathComponent(obtainNewsComponent)
        return URLRequest(url: url)
    }
    
    
    func parse(response: Data) throws -> Result<Item, ApiClientError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(AppDateFormatter.shared.serverFormatter())
        let decodedResponse = try decoder.decode((APIResponse<Item>).self, from: response)
        let news = decodedResponse.response
        
        return .success(news)
    }
}
