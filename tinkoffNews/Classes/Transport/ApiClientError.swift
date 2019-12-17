//
//  ApiClientError.swift
//  tinkoffNews
//
//  Created by Маргарита on 14/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

enum ApiClientError: Error {
    case invalidParseData(_: Data)
    case invalidSerializationObject(_: Any?)
    case invalidRequest
    case failedAnswer
}
