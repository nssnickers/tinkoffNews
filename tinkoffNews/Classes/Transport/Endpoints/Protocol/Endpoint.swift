//
//  Endpoint.swift
//  tinkoffNews
//
//  Created by Маргарита on 14/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Протокол endpoint
protocol Endpoint {
    associatedtype Item
    
    func request() throws -> URLRequest?
    func parse(response: Data) throws -> Result<Item, ApiClientError>
}
