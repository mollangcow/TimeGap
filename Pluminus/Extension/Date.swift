//
//  Date.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/17.
//

import Foundation

extension Date {
    public func currentDate(timeZoneOffset: Int) -> String {
        let formatter = DateFormatter()
        let currentTimeZone = TimeZone.current.secondsFromGMT()
        formatter.timeZone = TimeZone(secondsFromGMT: currentTimeZone + timeZoneOffset * 3600)
        
        formatter.dateFormat = "MMM d일 EEEE"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter.string(from: Date.now)
    }
    
    public func currentTime(timeZoneOffset: Int) -> String {
        let formatter = DateFormatter()
        let currentTimeZone = TimeZone.current.secondsFromGMT()
        formatter.timeZone = TimeZone(secondsFromGMT: currentTimeZone + timeZoneOffset * 3600)
        
        formatter.dateFormat = "HH:mm"
        
        return formatter.string(from: Date.now)
    }
    
    public func currentZone(timeZoneOffset: Int) -> String {
        let formatter = DateFormatter()
        let currentTimeZone = TimeZone.current.secondsFromGMT()
        formatter.timeZone = TimeZone(secondsFromGMT: currentTimeZone + timeZoneOffset * 3600)
        
        formatter.dateFormat = "z"
        
        return formatter.string(from: Date.now)
    }
}
