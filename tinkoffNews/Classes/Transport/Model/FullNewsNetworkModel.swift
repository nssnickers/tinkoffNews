//
//  FullNewsNetworkModel.swift
//  tinkoffNews
//
//  Created by Маргарита on 15/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Нетворк модель полной информации о новости
struct FullNewsNetworkModel: Codable {
    let id: String
    let title: String
    let date: Date
    let text: String
    let slug: String
}
