//
//  NewsListOutput.swift
//  tinkoffNews
//
//  Created by Маргарита on 15/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Протокол контроллера списка новостей
protocol NewsListOutput {
    
    func obtainData()
    
    func obtainMoreData()
    
    func obtainItemsCount() -> Int
    
    func obtainItemModelFor(_ indexPath: IndexPath) -> NewsListItem?
    
    func didSelectItemAt(_ indexPath: IndexPath)
}
