//
//  TimeFunctions.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/29.
//

import Foundation

func pickerResult(selectedPicker: [Int]) -> Int {
    let value = selectedPicker[1]
    return selectedPicker[0] == 1 ? -value : value
}

func gmtHereResult() -> Int {
    let formattedString = Date.now.formatted(.dateTime.timeZone())
    
    if let range = formattedString.range(of: "\\+\\d+", options: .regularExpression),
       let dateOffset = Int(formattedString[range].dropFirst()) {
        return dateOffset
    }
    
    return 0
}

func gmtTargetResult(selectedPicker: [Int]) -> Int {
    let formattedString = Date.now.formatted(.dateTime.timeZone())
    
    let pickerValue = pickerResult(selectedPicker: selectedPicker)
    
    if let range = formattedString.range(of: "\\+\\d+", options: .regularExpression),
       let dateOffset = Int(formattedString[range].dropFirst()) {
        return dateOffset + pickerValue
    }
    
    return 0
}

func gmtVisual(selectedPicker: [Int]) -> String {
    let gmt = gmtTargetResult(selectedPicker: selectedPicker)
    
    if gmt > 0 {
        let posGMT = "+\(gmt)"
        return posGMT
    } else if gmt < 0 {
        let negGMT = "\(gmt)"
        return negGMT
    }
    
    return "+0"
}

func targetHourResult(selectedPicker: [Int]) -> Int {
    let formattedString = Date().currentTime(timeZoneOffset: pickerResult(selectedPicker: selectedPicker))
    
    if let range = formattedString.range(of: "^(\\d+):", options: .regularExpression),
       let timeOffset = Int(formattedString[range].dropLast()) {
        return timeOffset
    }
    
    return 0
}
