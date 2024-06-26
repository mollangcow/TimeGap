//
//  TimeFunctions.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/29.
//

import Foundation

func selectPickerResult(selectedPicker: [Int]) -> Int {
    let value = selectedPicker[1]
    return selectedPicker[0] == 1 ? -value : value
}

func calcCurrentLocalGMT() -> Int {
    let formattedString = Date.now.formatted(.dateTime.timeZone())
    
    if let range = formattedString.range(of: "\\+\\d+", options: .regularExpression),
       let dateOffset = Int(formattedString[range].dropFirst()) {
        return dateOffset
    }
    
    return 0
}

func calcTargetLocalGMT(selectedPicker: [Int]) -> Int {
    let formattedString = Date.now.formatted(.dateTime.timeZone())
    
    let pickerValue = selectPickerResult(selectedPicker: selectedPicker)
    
    if let range = formattedString.range(of: "\\+\\d+", options: .regularExpression),
       let dateOffset = Int(formattedString[range].dropFirst()) {
        return dateOffset + pickerValue
    }
    
    return 0
}

func showingTargetLocalGMT(selectedPicker: [Int]) -> String {
    let gmt = calcTargetLocalGMT(selectedPicker: selectedPicker)
    
    if gmt > 0 {
        let posGMT = "+\(gmt)"
        return posGMT
    } else if gmt < 0 {
        let negGMT = "\(gmt)"
        return negGMT
    }
    
    return "+0"
}

func calcTargetLocalTimeHH(selectedPicker: [Int]) -> Int {
    let formattedString = Date().currentLocalTime(tzOffset: selectPickerResult(selectedPicker: selectedPicker))
    
    if let range = formattedString.range(of: "^(\\d+):", options: .regularExpression),
       let timeOffset = Int(formattedString[range].dropLast()) {
        return timeOffset
    }
    
    return 0
}
