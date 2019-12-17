//
//  ShortNewsNetworkModel.swift
//  tinkoffNews
//
//  Created by Маргарита on 15/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Нетворк модель  информации о новости для списка новостей
struct ShortNewsNetworkModel: Codable {
    let id: String
    let title: String
    let date: Date
    let slug: String
}
