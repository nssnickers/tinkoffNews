//
//  NewsPersistantEndpoint.swift
//  tinkoffNews
//
//  Created by Маргарита on 17/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import CoreData
import Foundation

class NewsPersistantEndpoint {
    
    private let entityName = "News"
    private let sortAttribute = "date"
    
    private var persistent: Persistent
    
    private var container: NSPersistentContainer {
        persistent.container
    }
    
    init(with persistent: Persistent) {
        self.persistent = persistent
    }
    
    func getNewNewsObject() -> News {
        NSEntityDescription.insertNewObject(forEntityName: entityName, into: container.viewContext) as! News
    }
    
    func saveNews(article: NewsArticle) {
        let persistNews = getNewNewsObject()
        persistNews.newsArticle = article
        
        persistent.saveContext()
    }
    
    func saveNewsList(list: [NewsArticle]) {
        let persistNews = list.map { (newsArticle) -> News in
            let news = self.getNewNewsObject()
            news.newsArticle = newsArticle
            return news
        }
        
        persistent.saveContext()
    }
    
    func getTotalNewsCount() -> Int? {
        let countRequest: NSFetchRequest<News> = News.fetchRequest()
        let totalCount = try? container.viewContext.count(for: countRequest)
        
        return totalCount
    }
    
    func getNewsList(with offset: Int, limit: Int) -> [News]? {
        let request: NSFetchRequest<News> = News.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: sortAttribute, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        request.fetchLimit = limit
        request.fetchOffset = offset
        
        return try? container.viewContext.fetch(request)
    }
    
    func getNewsBy(id: String) -> News? {
        let request: NSFetchRequest<News> = News.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "newsId == %@", id)
        
        return try? container.viewContext.fetch(request).first
    }
    
    func getNewsBy(url: String) -> News? {
        let request: NSFetchRequest<News> = News.fetchRequest()
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "urlSlug == %@", url)
        
        return try? container.viewContext.fetch(request).first
    }
}
