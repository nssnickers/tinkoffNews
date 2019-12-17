//
//  NewsListEndpoint.swift
//  tinkoffNews
//
//  Created by Маргарита on 14/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Структура для парсинга списка новостей
struct NewsList<Content>: Codable where Content: Codable {
    let news: Content
    let total: Int
}

/// Endpoint для запроса списка новостей
struct NewsListEndpoint: Endpoint {
    
    // MARK: - Types
    
    typealias Item = NewsList<[ShortNewsNetworkModel]>
    
    // MARK: - Private Properties
    
    private var offset: Int
    private var limit: Int
    
    // MARK: - Initializers
    
    init(offset: Int, limit: Int) {
        self.offset = offset
        self.limit = limit
    }
    
    // MARK: - Public Methods
    
    func request() throws -> URLRequest? {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = Api.Url.scheme
        urlComponents.host = Api.Url.host
        urlComponents.path = Api.Url.path
        
        let queryParams = [
            URLQueryItem(name: "pageSize", value: "\(limit)"),
            URLQueryItem(name: "pageOffset", value: "\(offset)")
        ]
        
        urlComponents.queryItems = queryParams
        
        guard var url = urlComponents.url else { return nil }
        let obtainNewsPathComponent = Api.NewsPath.obtainList
        
        url.appendPathComponent(obtainNewsPathComponent)
        
        
        return URLRequest(url: url)
    }
    
    func parse(response: Data) throws -> Result<Item, ApiClientError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(AppDateFormatter.shared.serverFormatter())
        let decodedResponse = try decoder.decode((APIResponse<Item>).self, from: response)
        let newsList = decodedResponse.response
        
        return .success(newsList)
    }
}
