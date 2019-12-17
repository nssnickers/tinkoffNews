//
//  NewsArticle.swift
//  tinkoffNews
//
//  Created by Маргарита on 15/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Модель новости
class NewsArticle {
    
    let id: String
    let date: Date
    let title: String
    let url: String
    let text: String?
    var viewsCount: Int
    
    init(with persistanceModel: News) {
        self.id = persistanceModel.newsId
        self.date = persistanceModel.date
        self.title = persistanceModel.title
        self.url = persistanceModel.urlSlug
        self.text = persistanceModel.text
        self.viewsCount = Int(persistanceModel.viewsCount)
    }
    
    init(with articleNetworkModel: FullNewsNetworkModel, viewsCount: Int) {
        self.id = articleNetworkModel.id
        self.date = articleNetworkModel.date
        self.title = articleNetworkModel.title
        self.url = articleNetworkModel.slug
        self.text = articleNetworkModel.text
        self.viewsCount = viewsCount
    }
    
    init(with listItemNetworkModel: ShortNewsNetworkModel, viewsCount: Int) {
        self.id = listItemNetworkModel.id
        self.date = listItemNetworkModel.date
        self.title = listItemNetworkModel.title
        self.url = listItemNetworkModel.slug
        self.viewsCount = viewsCount
        self.text = nil
    }
    
    func getUrl() -> String {
        url
    }
    
    func increaseViewsCount() {
        viewsCount += 1
    }
}

extension NewsArticle: NewsListItem {
    
    func getDate() -> String {
        AppDateFormatter.shared.dayMonthDate(from: date) ?? ""
    }
    
    func getTitle() -> String {
        title
    }
    
    func getViewsCount() -> Int {
        viewsCount
    }
}

extension NewsArticle: NewsArticleModel {
    
    func getText() -> NSAttributedString {
        let emptyString = NSAttributedString(string: "")
        guard let text = text else { return emptyString }
        
        let htmlData = NSString(string: text).data(using: String.Encoding.unicode.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        let attributedString = try? NSMutableAttributedString(data: htmlData ?? Data(),
                                                                  options: options,
                                                                  documentAttributes: nil)
        return attributedString ?? emptyString
    }
}
