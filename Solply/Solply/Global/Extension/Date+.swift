//
//  Date+.swift
//  Solply
//
//  Created by sun on 3/19/26.
//

import Foundation

extension Date {
    var yyyyMMddString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
