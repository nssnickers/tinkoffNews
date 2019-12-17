//
//  NewsServiceProtocol.swift
//  tinkoffNews
//
//  Created by Маргарита on 17/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

protocol NewsServiceProtocol {
    func getNews(with slug: String, completion: @escaping (Result<NewsArticle, BusinessLogicError>) -> Void)
}
