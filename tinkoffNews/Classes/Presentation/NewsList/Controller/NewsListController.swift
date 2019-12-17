//
//  NewsListController.swift
//  tinkoffNews
//
//  Created by Маргарита on 15/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

fileprivate let defaultLimit = 20

class NewsListController: NewsListOutput {
    
    // MARK: - Private Properties
    
    private weak var view: NewsListInput?
    
    private let service: NewsListServiceProtocol
    
    private var offset: Int = 0
    private var limit: Int = defaultLimit
    
    private var newsList: [NewsArticle] = []
    private var totalCount: Int = 0
    
    // MARK: - Initializers
    
    init(view: NewsListInput, service: NewsListServiceProtocol) {
        self.view = view
        self.service = service
    }
    
    // MARK: - Public Methods
    
    func obtainData() {
        offset = 0
        loadData(refresh: true)
    }
    
    func obtainMoreData() {
        loadData(refresh: false)
    }
    
    func obtainItemsCount() -> Int {
        newsList.count
    }
    
    func obtainItemModelFor(_ indexPath: IndexPath) -> NewsListItem? {
        guard newsList.count > indexPath.item else { return nil }
        
        return newsList[indexPath.item]
    }
    
    func didSelectItemAt(_ indexPath: IndexPath) {
        guard let url = obtainItemUrlFor(indexPath) else { return }
        service.increaseViewsCountForNews(news: newsList[indexPath.item])
        
        let oneNews = OneNewsViewController()
        oneNews.setup(urlSlug: url)
        oneNews.newsService = NewsAssembly().getNewsService()
        oneNews.increaseAction = {
            self.view?.reloadRow(at: indexPath)
        }
        
        view?.showView(oneNews)
    }
    
    // MARK: - Private Methods
    
    private func loadData(refresh: Bool) {
        
        service.getNewsList(with: offset, limit: limit) { (result) in
            switch result {
            case .success(let newsList):
                self.totalCount = newsList.totalCount
                
                if refresh {
                    self.newsList = newsList.news
                    self.view?.stopRefresh()
                } else {
                    self.newsList += newsList.news
                }
                self.view?.reload()
                self.offset += defaultLimit
            case .failure(let error):
                self.view?.showError(with: "Невозможно получить данные, попробуйте позже")
            }
        }
    }
    
    private func obtainItemUrlFor(_ indexPath: IndexPath) -> String? {
        guard newsList.count > indexPath.item else { return nil }
        
        return newsList[indexPath.item].getUrl()
    }
}
