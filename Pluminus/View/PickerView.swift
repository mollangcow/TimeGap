//
//  PickerView.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/04.
//

import SwiftUI

struct PickerView: View {

    @StateObject var locationManager = MyLocationManager()

    @State private var dataSource: [[String]] = [["+","-"], []]
    @State private var pickerFastOrSlow: [String] = ["빠른", "+"]
    @State private var rectangleHeight: CGFloat = 1
    @State private var pickerHour: Int = 0
    
    @Binding var selected: [Int]
    @Binding var isPickerView: Bool

    init(isPickerView: Binding<Bool>, selected: Binding<[Int]>) {
        self._isPickerView = isPickerView
        self._selected = selected
        _ = self.hourRange
    }
    
    var body: some View {
        VStack {
            if isPickerView {
                // 메인 피커 뷰
                Spacer()
                HStack {
                    // 타임 피커 로직
                    CustomPicker(dataSource: $dataSource, selected: $selected)
                        .frame(width:160)
                        .id(dataSource)
                        .onChange(of: selected[0]) { newValue in
                            print(">>>>> PICKER OnChange(selected[0])")
                            pickerFastOrSlow = newValue == 0 ? ["빠른", "+"] : ["느린", "-"]
                            _ = hourRange
                            dataSource[1] = Array(hourRange).map { String($0) }
                            _ = gmtTargetResult()
                        }
                        .onChange(of: selected[1]) { newValue in
                            HapticManager.instance.impact(style: .medium)
                            print(">>>>> PICKER OnChange(selected[1])")
                            pickerHour = newValue
                            _ = hourRange
                            dataSource[1] = Array(hourRange).map { String($0) }
                            _ = gmtTargetResult()
                        }
                        .onChange(of: dataSource) { newValue in
                            HapticManager.instance.impact(style: .medium)
                            print(">>>>> PICKER OnChange(dataSource)")
                            _ = hourRange
                            dataSource[1] = Array(hourRange).map { String($0) }
                        }
                        .onAppear(perform: {
                            print(">>>>> PICKER OnAppear")
                            _ = gmtTargetResult()
                            _ = hourRange
                            dataSource[1] = Array(hourRange).map { String($0) }
                        })
                        .onDisappear {
                            print(">>>>> PICKER OnDisappear")
                            _ = gmtTargetResult()
                            _ = hourRange
                            dataSource[1] = Array(hourRange).map { String($0) }
                        }
                        
                    Text("시간")
                        .font(.system(size: 17, weight: .bold))
                } // HStack닫기
                
                Spacer()
                
                ZStack {
                    HStack {
                        Text("GMT-12")
                            .font(.system(size: 11, weight: .light))
                        
                        Rectangle()
                            .frame(width: 260, height: 1)
                            .foregroundColor(.secondary)
                        
                        Text("GMT+14")
                            .font(.system(size: 11, weight: .light))
                    }
                    
                    HStack {
                        Spacer()
                            .frame(width: pickerVisualStaticSpacer())
                        
                        Rectangle()
                            .frame(width: 2, height: 10)
                            .foregroundColor(.primary.opacity(0.3))
                        
                        Spacer()
                    }
                    .frame(width: 260)
                    
                    HStack {
                        Spacer()
                            .frame(width: pickerVisualMovingSpacer())
                        
                        Rectangle()
                            .frame(width: 2, height: 10)
                            .foregroundColor(.primary)
                        
                        Spacer()
                    }
                    .frame(width: 260)
                }
                
                Text("현재 위치보다 \(pickerHour)시간 \(pickerFastOrSlow[0]) 주요 지역")
                    .font(.system(size: 14, weight: .regular))
                    .padding(.top, 10)
                    .padding(.bottom, 40)
            } else {
                VStack(alignment: .leading) {
                    VStack {
                        HStack(alignment: .bottom) {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(
                                            colors: [
                                                .white.opacity(0),
                                                .white.opacity(1)
                                            ]
                                        ),
                                        startPoint: .top,
                                        endPoint: .bottom)
                                )
                                .frame(width: 2, height: rectangleHeight)
                                .padding(.leading, 20)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 1.0)) {
                                        rectangleHeight = calcTimeGapStrokeHeight(pickerHour: pickerHour)
                                    }
                                }
                                .onDisappear {
                                    rectangleHeight = 1
                                }
                            Text("\(pickerFastOrSlow[1]) \(pickerHour)시간")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                    }
                    .frame(height: screenHeight * 0.2)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(alignment: .bottom) {
                            Text(Date.currentTime(timeZoneOffset: pickerResult()))
                                .font(.system(size: 64, weight: .heavy))
                                .foregroundColor(.white)
                            Text("GMT\(gmtVisual())")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.white.opacity(0.7))
                                .padding(.bottom, 16)
                        }
                        Text(Date.currentDate(timeZoneOffset: pickerResult()))
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.leading, 4)
                    }
                    .frame(height: 120)
                    .padding(.bottom, 10)
                    
                    ScrollView {
                        NationView(
                            pickerHour: $pickerHour,
                            pickerFastOrSlow: $pickerFastOrSlow,
                            selected: $selected
                        )
                    }
                    .scrollIndicators(.hidden)
                } // VStack닫기
                .padding(.horizontal, 20)
            } // if닫기
        } //VStack닫기
    } // body닫기
    
    private func pickerVisualMovingSpacer() -> CGFloat {
        let hour = gmtTargetResult()
        
        if hour == -12 {
            return 0
        } else if hour == 0 {
            return 130
        } else if hour >= -11 && hour <= 14 {
            return CGFloat(hour + 12) * 10
        }
        
        return 0
    }
    
    private func pickerVisualStaticSpacer() -> CGFloat {
        let hour = gmtHereResult()
        
        if hour == -12 {
            return 0
        } else if hour == 0 {
            return 130
        } else if hour >= -11 && hour <= 14 {
            return CGFloat(hour + 12) * 10
        }
        
        return 0
    }
    
    private func calcTimeGapStrokeHeight(pickerHour: Int) -> CGFloat {
        let minHeight: CGFloat = screenHeight * 0.02
        let maxHeight: CGFloat = screenHeight * 0.2
        let hourRange: ClosedRange<Int> = 0...27
        
        let normalizedHour = CGFloat(pickerHour - hourRange.lowerBound) / CGFloat(hourRange.upperBound - hourRange.lowerBound)
        
        let calculatedHeight = minHeight + (maxHeight - minHeight) * normalizedHour
        
        return calculatedHeight
    }
    
    func pickerResult() -> Int {
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
    
    func gmtTargetResult() -> Int {
        let formattedString = Date.now.formatted(.dateTime.timeZone())
        
        let pickerValue = pickerResult()
        
        if let range = formattedString.range(of: "\\+\\d+", options: .regularExpression),
           let dateOffset = Int(formattedString[range].dropFirst()) {
            return dateOffset + pickerValue
        }
        
        return 0
    }
    
    func gmtVisual() -> String {
        let gmt = gmtTargetResult()
        
        if gmt > 0 {
            let posGMT = "+\(gmt)"
            return posGMT
        } else if gmt < 0 {
            let negGMT = "\(gmt)"
            return negGMT
        }
        
        return "+0"
    }
    
    private var hourRange: ClosedRange<Int> {
        var wrappedGMT = gmtHereResult() <= -11 ? -10 : gmtHereResult()
        wrappedGMT = gmtHereResult() >= 14 ? 13 : gmtHereResult()
        
        if selected[0] == 0 {
            let min = 0
            let max = 14 - wrappedGMT
            
            return min...max
            
        } else {
            let min = 0
            let max = abs(-12 - wrappedGMT)
            
            return min...max
        }
    }
} // struct닫기
