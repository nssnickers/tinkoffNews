//
//  BusinessLogicError.swift
//  tinkoffNews
//
//  Created by Маргарита on 17/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

enum BusinessLogicError: Error {
    case emptyDataFromNetwork(sub: ApiClientError)
    case emptyDataFromPersistency(sub: PersistencyError)
}

enum PersistencyError: Error {
    // TODO
}
