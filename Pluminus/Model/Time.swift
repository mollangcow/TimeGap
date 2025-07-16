//
//  TimeFunctions.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/29.
//

import Foundation
import Combine

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

class TimeViewModel: ObservableObject {
    @Published var currentTimeHMMSSString: String = ""
    @Published var currentDateString: String = ""

    private var timer: Timer?

    init() {
        updateTime()
        startUpdatingTime()
    }

    deinit {
        stopUpdatingTime()
    }

    private func startUpdatingTime() {
        // Run on main thread to update UI
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTime()
        }
    }

    private func stopUpdatingTime() {
        timer?.invalidate()
        timer = nil
    }

    private func updateTime() {
        let now = Date()
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        currentTimeHMMSSString = timeFormatter.string(from: now)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d"
        currentDateString = dateFormatter.string(from: now)
    }
}
