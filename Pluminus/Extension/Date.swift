//
//  Date.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/17.
//

import SwiftUI

extension Date {
    public static func currentDate(timeZoneOffset: Int) -> String {
        let now = Date()
        
        let formatter = DateFormatter()
        
        let currentTimeZone = TimeZone.current.secondsFromGMT(for: now)
        formatter.timeZone = TimeZone(secondsFromGMT: currentTimeZone + timeZoneOffset * 3600)
        
        formatter.dateFormat = "MMM d일 EEEE"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter.string(from: now)
    }
    
    public static func currentTime(timeZoneOffset: Int) -> String {
        let now = Date()
        
        let formatter = DateFormatter()
        
        let currentTimeZone = TimeZone.current.secondsFromGMT(for: now)
        formatter.timeZone = TimeZone(secondsFromGMT: currentTimeZone + timeZoneOffset * 3600)
        
        formatter.dateFormat = "HH:mm"
        
        return formatter.string(from: now)
    }
    
    public static func currentZone(timeZoneOffset: Int) -> String {
        let now = Date()
        
        let formatter = DateFormatter()
        
        let currentTimeZone = TimeZone.current.secondsFromGMT(for: now)
        formatter.timeZone = TimeZone(secondsFromGMT: currentTimeZone + timeZoneOffset * 3600)
        
        formatter.dateFormat = "z"
        
        return formatter.string(from: now)
    }
}
