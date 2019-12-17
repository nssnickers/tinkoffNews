//
//  AppDelegate.swift
//  tinkoffNews
//
//  Created by Маргарита on 14/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        window?.rootViewController = NewsAssembly().getNewsListView()
        window?.makeKeyAndVisible()
        
        return true
    }
}

