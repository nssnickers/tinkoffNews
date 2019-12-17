//
//  NewsService.swift
//  tinkoffNews
//
//  Created by Маргарита on 14/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

class NewsService {
    
    private let persistentClient: NewsPersistantEndpoint
    
    init(with persistentClient: NewsPersistantEndpoint) {
        self.persistentClient = persistentClient
    }
    
}

// MARK: - NewsListServiceProtocol

extension NewsService: NewsListServiceProtocol {
    
    func getNewsList(with offset: Int, limit: Int, completion: @escaping (Result<NewsListModel, BusinessLogicError>) -> Void) {
        
        getNewsListFromPersistency(with: offset, limit: limit) { (result) in
            switch result {
            case .success(let news):
                completion(.success(news))
            case .failure(let error):
                completion(.failure(.emptyDataFromPersistency(sub: error)))
            }
        }
        
        getNewsListFromNetwork(with: offset, limit: limit) { (result) in
            switch result {
            case .success(let newsListModel):
                self.persistentClient.saveNewsList(list: newsListModel.news)
                completion(.success(newsListModel))
            case .failure(let error):
                completion(.failure(.emptyDataFromNetwork(sub: error)))
            }
        }
    }
    
    func increaseViewsCountForNews(news: NewsArticle) {
        news.increaseViewsCount()
        self.persistentClient.saveNews(article: news)
    }
    
    // MARK: - Private Methods
    
    private func getNewsListFromNetwork(with offset: Int,
                                        limit: Int,
                                        completion: @escaping (Result<NewsListModel, ApiClientError>) -> Void) {
        let endpoint = NewsListEndpoint(offset: offset, limit: limit)
        Client.request(with: endpoint) { (result) in
            switch result {
            
            case .success(let newsList):
                let news = newsList.news.map { (networkModel) -> NewsArticle in
                    let viewsCount = self.getNewsFromPersistency(id: networkModel.id)?.getViewsCount() ?? 0
                    return NewsArticle(with: networkModel, viewsCount: viewsCount)
                }
                
                let newsModel = NewsListModel(news: news, totalCount: newsList.total)
                completion(.success(newsModel))
            
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func getNewsListFromPersistency(with offset: Int,
                                            limit: Int,
                                            completion: @escaping (Result<NewsListModel, PersistencyError>) -> Void) {
        if let totalCount = persistentClient.getTotalNewsCount(),
            totalCount > offset,
            let news = persistentClient.getNewsList(with: offset, limit: limit) {
            
            let newsList = news.map({ return NewsArticle(with: $0) })
            let newsModel = NewsListModel(news: newsList, totalCount: totalCount)
            
            completion(.success(newsModel))
        }
    }
}

// MARK: - NewsServiceProtocol

extension NewsService: NewsServiceProtocol {
    
    func getNews(with slug: String, completion: @escaping (Result<NewsArticle, BusinessLogicError>) -> Void) {
        
        getNewsFromPersistency(with: slug) { (result) in
            switch result {
            case .success(let news):
                completion(.success(news))
            case .failure(let error):
                completion(.failure(.emptyDataFromPersistency(sub: error)))
            }
        }
        
        getNewsFromNetwork(with: slug) { (result) in
            switch result {
            case .success(let news):
                self.persistentClient.saveNews(article: news)
                completion(.success(news))
            case .failure(let error):
                completion(.failure(.emptyDataFromNetwork(sub: error)))
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func getNewsFromNetwork(with slug: String,
                                    completion: @escaping (Result<NewsArticle, ApiClientError>) -> Void) {
        let endpoint = NewsEndpoint(urlSlug: slug)
        Client.request(with: endpoint) { (result) in
            switch result{
            case .success(let fullNews):
                let viewsCount = self.getNewsFromPersistency(id: fullNews.id)?.getViewsCount() ?? 0
                let news = NewsArticle(with: fullNews, viewsCount: viewsCount)
                completion(.success(news))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func getNewsFromPersistency(with slug: String,
                                        completion: @escaping (Result<NewsArticle, PersistencyError>) -> Void) {
        if let news = persistentClient.getNewsBy(url: slug) {
            let newsArticle = NewsArticle(with: news)
            completion(.success(newsArticle))
        }
    }
    
    private func getNewsFromPersistency(id: String) -> NewsArticle? {
        if let news = persistentClient.getNewsBy(id: id) {
            return NewsArticle(with: news)
        }
        
        return nil
    }

}
