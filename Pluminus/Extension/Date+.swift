//
//  Date.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/17.
//

import Foundation

extension Date {
    public func currentLocalDate(tzOffset: Int) -> String {
        let formatter = DateFormatter()
        let currentTimeZone = TimeZone.current.secondsFromGMT()
        
        formatter.timeZone = TimeZone(secondsFromGMT: currentTimeZone + tzOffset * 3600)
                
        formatter.dateFormat = "MMM d일 EEEE"
        formatter.locale = Locale(identifier: "ko_KR")
        
        return formatter.string(from: Date.now)
    }
    
    public func currentLocalTime(tzOffset: Int) -> String {
        let formatter = DateFormatter()
        let currentTimeZoneOffset = TimeZone.current.secondsFromGMT()
        let offsetInSeconds = tzOffset * 3600
        let targetTimeZone = TimeZone(secondsFromGMT: currentTimeZoneOffset + offsetInSeconds)
        
        formatter.timeZone = targetTimeZone
        formatter.dateFormat = "HH:mm"
        
        return formatter.string(from: Date())
    }
    
    public func currentLocalZone(tzOffset: Int) -> String {
        let formatter = DateFormatter()
        let currentTimeZone = TimeZone.current.secondsFromGMT()
        formatter.timeZone = TimeZone(secondsFromGMT: currentTimeZone + tzOffset * 3600)
        
        formatter.dateFormat = "z"
        
        return formatter.string(from: Date.now)
    }
}
