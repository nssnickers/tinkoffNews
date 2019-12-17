//
//  NewsArticle+NewsArticleModel.swift
//  tinkoffNews
//
//  Created by Маргарита on 16/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Протокол модели новости
protocol NewsArticleModel {
    func getDate() -> String
    func getTitle() -> String
    func getViewsCount() -> Int
    func getText() -> NSAttributedString
}
