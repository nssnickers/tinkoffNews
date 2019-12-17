//
//  AppDateFormatter.swift
//  tinkoffNews
//
//  Created by Маргарита on 15/12/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Форматтер даты 
class AppDateFormatter {

    // MARK: - Constants

    static let shared = AppDateFormatter()

    private let formatter = DateFormatter()

    private let dayMonthYearFormat = "d MMMM yyyy"
    private let serverDateTimeFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"

    // MARK: - Private Properties

    private var calendar = Calendar.current

    // MARK: - Initializers

    private init() {
        formatter.locale = Locale(identifier: "ru")
        calendar.locale = Locale(identifier: "ru")
    }

    // MARK: - Public Methods
    func serverFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = serverDateTimeFormat
        return formatter
    }

    func dayMonthDate(for dateString: String) -> String? {
        formatter.dateFormat = serverDateTimeFormat

        guard let date = formatter.date(from: dateString) else { return nil }
        formatter.dateFormat = dayMonthYearFormat

        return formatter.string(from: date)
    }
    
    func date(for dateString: String) -> Date? {
        formatter.dateFormat = dayMonthYearFormat
        return formatter.date(from: dateString)
    }
    
    func dayMonthDate(from date: Date?) -> String? {
        guard let date = date else { return nil }
        formatter.dateFormat = dayMonthYearFormat
        return formatter.string(from: date)
    }
}
