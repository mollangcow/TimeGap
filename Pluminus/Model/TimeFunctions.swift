//
//  TimeFunctions.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/29.
//

import Foundation
import SwiftUI

func pickerResult(selected: [Int]) -> Int {
    let value = selected[1]
    return selected[0] == 1 ? -value : value
}

func gmtHereResult() -> Int {
    let formattedString = Date.now.formatted(.dateTime.timeZone())
    
    if let range = formattedString.range(of: "\\+\\d+", options: .regularExpression),
       let dateOffset = Int(formattedString[range].dropFirst()) {
        return dateOffset
    }
    
    return 0
}

func gmtTargetResult(selected: [Int]) -> Int {
    let formattedString = Date.now.formatted(.dateTime.timeZone())
    
    let pickerValue = pickerResult(selected: selected)
    
    if let range = formattedString.range(of: "\\+\\d+", options: .regularExpression),
       let dateOffset = Int(formattedString[range].dropFirst()) {
        return dateOffset + pickerValue
    }
    
    return 0
}

func gmtVisual(selected: [Int]) -> String {
    let gmt = gmtTargetResult(selected: selected)
    
    if gmt > 0 {
        let posGMT = "+\(gmt)"
        return posGMT
    } else if gmt < 0 {
        let negGMT = "\(gmt)"
        return negGMT
    }
    
    return "+0"
}

func targetHourResult(selected: [Int]) -> Int {
    let formattedString = Date().currentTime(timeZoneOffset: pickerResult(selected: selected))
    
    if let range = formattedString.range(of: "^(\\d+):", options: .regularExpression),
       let timeOffset = Int(formattedString[range].dropLast()) {
        return timeOffset
    }
    
    return 0
}
