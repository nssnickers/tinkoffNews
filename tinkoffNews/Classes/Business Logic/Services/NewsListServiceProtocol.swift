//
//  NewsListServiceProtocol.swift
//  tinkoffNews
//
//  Created by Маргарита on 17/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

protocol NewsListServiceProtocol {
    
    func getNewsList(with offset: Int,
                     limit: Int,
                     completion: @escaping (Result<NewsListModel, BusinessLogicError>) -> Void)
    
    func increaseViewsCountForNews(news: NewsArticle)
}
