//
//  ApiResponse.swift
//  tinkoffNews
//
//  Created by Маргарита on 14/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Структура описывает ответ сервера для парсинга
struct APIResponse<Content>: Codable where Content: Codable {
    let response: Content
}
