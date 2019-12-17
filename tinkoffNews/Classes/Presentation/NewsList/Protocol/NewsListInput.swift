//
//  NewsListInput.swift
//  tinkoffNews
//
//  Created by Маргарита on 15/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import UIKit

/// Протокол вью списка новостей
protocol NewsListInput: UIViewController {
    
    func stopRefresh()
    
    func reload()
    
    func showView(_ view: UIViewController)
    
    func reloadRow(at indexPath: IndexPath)
    
    func showError(with message: String)
}
