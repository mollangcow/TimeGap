//
//  Date.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/16.
//

import SwiftUI

extension String {
    func stringDate(date: Date, dateFormat: String) -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: now)
    }
}
