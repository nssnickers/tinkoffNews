//
//  Persistent.swift
//  tinkoffNews
//
//  Created by Маргарита on 17/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import CoreData
import Foundation

class Persistent: NSObject {
    
    private let modelName = "tinkoffNews"
    
    static let shared = Persistent()
    var container: NSPersistentContainer
    
    private override init() {
        container = NSPersistentContainer(name: modelName)
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
