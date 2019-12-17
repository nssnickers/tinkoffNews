//
//  NewsAssembly.swift
//  tinkoffNews
//
//  Created by Маргарита on 15/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

class NewsAssembly {
    
    // MARK: - Private Properties
    
    private let persistent = Persistent.shared
    
    // MARK: - Public Methods
    
    func getNewsListView() -> NewsListInput {
        let view = NewsListViewController()
        view.controller = getControllerFor(view, service: getNewsListService())
        
        return view
    }
    
    // MARK: - Private Methods
    
    func getNewsService() -> NewsServiceProtocol {
        NewsService(with: NewsPersistantEndpoint(with: persistent))
    }
    
    func getNewsListService() -> NewsListServiceProtocol {
        NewsService(with: NewsPersistantEndpoint(with: persistent))
    }
    
    private func getControllerFor(_ view: NewsListInput, service: NewsListServiceProtocol) -> NewsListOutput {
        return NewsListController(view: view, service: service)
    }
}
