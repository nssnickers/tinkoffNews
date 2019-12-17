//
//  TransportConstants.swift
//  tinkoffNews
//
//  Created by Маргарита on 14/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

// MARK: - Запросы к серверу

/// Запросы к серверу
struct Api {
    
    /// Базовый URL сервера
    struct Url {
        
        static let scheme = "https"
        
        static let host = "cfg.tinkoff.ru"
        
        static let path = "/news/public/api/platform/v1/"
        
    }
    
    struct Macros {
        static let newsOffset = "pageOffset"
        
        static let newsLimit = "pageSize"
        
        static let newsUrl = "urlSlug"
    }
    
    
    /// Запросы  новостей
    struct NewsPath {
        
        static let obtainList = "getArticles"
        
        static let obtainOne = "getArticle"
    }
}
