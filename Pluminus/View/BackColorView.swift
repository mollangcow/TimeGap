//
//  BackColorView.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/07.
//

import SwiftUI

struct BackColorView: View {

    @Binding var isPickerView: Bool
    @Binding var selected: [Int]
    
    func pickerResult() -> Int {
        let value = selected[1]
        return selected[0] == 1 ? -value : value
    }
    
    func targetHourResult() -> Int {
        let formattedString = Date.currentTime(timeZoneOffset: pickerResult())
        
        if let range = formattedString.range(of: "^(\\d+):", options: .regularExpression),
           let timeOffset = Int(formattedString[range].dropLast()) {
            return timeOffset
        }
        
        return 0
    }
    
    var body: some View {
        ZStack {
            if isPickerView {
                EmptyView()
            } else {
                getBackgroundColor()
                    .edgesIgnoringSafeArea(.all)
            }
        }
    } // body닫기

    func getBackgroundColor() -> LinearGradient {
        if targetHourResult() == 1 || targetHourResult() == 2 {
            return LinearGradient(gradient: Gradient(colors: [Color.G0102_Top, Color.G0102_Center, Color.G0102_Bottom]),
                            startPoint: .center, endPoint: .bottom)
        }
        else if targetHourResult() == 3 || targetHourResult() == 4 {
            return LinearGradient(gradient: Gradient(colors: [Color.G0304_Top, Color.G0304_Center, Color.G0304_Bottom]),
                            startPoint: .center, endPoint: .bottom)
        }
        else if targetHourResult() == 5 || targetHourResult() == 6 {
            return LinearGradient(gradient: Gradient(colors: [Color.G0506_Top, Color.G0506_Center, Color.G0506_Bottom]),
                            startPoint: .center, endPoint: .bottom)
        }
        else if targetHourResult() == 7 || targetHourResult() == 8 {
            return LinearGradient(gradient: Gradient(colors: [Color.G0708_Top, Color.G0708_Center, Color.G0708_Bottom]),
                           startPoint: .center, endPoint: .bottom)
        }
        else if targetHourResult() == 9 || targetHourResult() == 10 {
            return LinearGradient(gradient: Gradient(colors: [Color.G0910_Top, Color.G0910_Center, Color.G0910_Bottom]),
                           startPoint: .center, endPoint: .bottom)
        }
        else if targetHourResult() == 11 || targetHourResult() == 12 {
            return LinearGradient(gradient: Gradient(colors: [Color.G1112_Top, Color.G1112_Center, Color.G1112_Bottom]),
                           startPoint: .center, endPoint: .bottom)
        }
        else if targetHourResult() == 13 || targetHourResult() == 14 {
            return LinearGradient(gradient: Gradient(colors: [Color.G1314_Top, Color.G1314_Center, Color.G1314_Bottom]),
                           startPoint: .center, endPoint: .bottom)
        }
        else if targetHourResult() == 15 || targetHourResult() == 16 {
            return LinearGradient(gradient: Gradient(colors: [Color.G1516_Top, Color.G1516_Center, Color.G1516_Bottom]),
                           startPoint: .center, endPoint: .bottom)
        }
        else if targetHourResult() == 17 || targetHourResult() == 18 {
            return LinearGradient(gradient: Gradient(colors: [Color.G1718_Top, Color.G1718_Center, Color.G1718_Bottom]),
                           startPoint: .center, endPoint: .bottom)
        }
        else if targetHourResult() == 19 || targetHourResult() == 20 {
            return LinearGradient(gradient: Gradient(colors: [Color.G1920_Top, Color.G1920_Center, Color.G1920_Bottom]),
                           startPoint: .center, endPoint: .bottom)
        }
        else if targetHourResult() == 21 || targetHourResult() == 22 {
            return LinearGradient(gradient: Gradient(colors: [Color.G2122_Top, Color.G2122_Center, Color.G2122_Bottom]),
                           startPoint: .center, endPoint: .bottom)
        }
        else if targetHourResult() == 23 || targetHourResult() == 0 {
            return LinearGradient(gradient: Gradient(colors: [Color.G2300_Top, Color.G2300_Center, Color.G2300_Bottom]),
                           startPoint: .center, endPoint: .bottom)
        }
        else {
            return LinearGradient(gradient: Gradient(colors: [Color.primary, Color.primary, Color.primary]),
                           startPoint: .center, endPoint: .bottom)
        }
    } // func닫기
} // struct닫기
