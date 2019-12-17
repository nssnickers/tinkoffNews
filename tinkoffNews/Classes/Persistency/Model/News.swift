//
//  News.swift
//  tinkoffNews
//
//  Created by Маргарита on 16/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import CoreData
import Foundation

@objc(News)
class News: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var date: Date
    @NSManaged public var newsId: String
    @NSManaged public var text: String?
    @NSManaged public var title: String
    @NSManaged public var urlSlug: String
    @NSManaged public var viewsCount: Int32
    
    var newsArticle : NewsArticle {
        get {
            return NewsArticle(with: self)
        }
        set {
            self.date = newValue.date
            self.newsId = newValue.id
            self.text = newValue.text
            self.title = newValue.title
            self.urlSlug = newValue.url
            self.viewsCount = Int32(newValue.viewsCount)
        }
    }
}
