//
//  PickerView.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/04.
//

import SwiftUI

struct NationAndPickerView: View {
    @StateObject var locationManager = MyLocationManager()

    @State private var dataSource: [[String]] = [["+","-"], []]
    @State private var pickerFastOrSlow: [String] = ["빠른", "+"]
    @State private var rectangleHeight: CGFloat = 1
    @State private var pickerHour: Int = 0
    
    @Binding var selectedPicker: [Int]
    @Binding var isShowingResult: Bool
    
    var body: some View {
        switch isShowingResult {
        case true:
            return AnyView(PickerContentView)
        case false:
            return AnyView(NationContentView)
        }
    } // body
    
    var PickerContentView: some View {
        VStack {
            Spacer()
            
            // 커스텀 피커 뷰
            HStack {
                CustomPicker(dataSource: $dataSource, selectedPicker: $selectedPicker)
                    .frame(width:160)
                    .id(dataSource)
                    .onChange(of: selectedPicker[0]) { oldValue, newValue in
                        print(">>>>> Picker OnChange [0] : \(selectedPicker[0])")
                        pickerFastOrSlow = newValue == 0 ? ["빠른", "+"] : ["느린", "-"]
                        _ = hourRange
                        dataSource[1] = Array(hourRange).map { String($0) }
                        _ = calcTargetLocalGMT(selectedPicker: selectedPicker)
                    }
                    .onChange(of: selectedPicker[1]) { oldValue, newValue in
                        HapticManager.instance.impact(style: .medium)
                        print(">>>>> Picker OnChange [1] : \(selectedPicker[1])")
                        pickerHour = newValue
                        _ = hourRange
                        dataSource[1] = Array(hourRange).map { String($0) }
                        _ = calcTargetLocalGMT(selectedPicker: selectedPicker)
                    }
                    .onChange(of: dataSource) { oldValue, newValue in
                        HapticManager.instance.impact(style: .medium)
                        print("<<<<< Picker OnChange(dataSource)")
                        _ = hourRange
                        dataSource[1] = Array(hourRange).map { String($0) }
                    }
                    .onAppear(perform: {
                        print("^^^^^ Picker OnAppear")
                        _ = calcTargetLocalGMT(selectedPicker: selectedPicker)
                        _ = hourRange
                        dataSource[1] = Array(hourRange).map { String($0) }
                    })
                    .onDisappear {
                        print("^^^^^ Picker OnDisappear")
                        _ = calcTargetLocalGMT(selectedPicker: selectedPicker)
                        _ = hourRange
                        dataSource[1] = Array(hourRange).map { String($0) }
                    }
                    
                Text("시간")
                    .font(.system(size: 17, weight: .bold))
            } // HStack
            
            Spacer()
            
            // GMT 시간대 시각화 그래프
            ZStack {
                HStack {
                    Text("GMT-12")
                        .font(.system(size: 8, weight: .regular))
                    
                    Rectangle()
                        .frame(width: 260, height: 1)
                        .foregroundColor(.gray.opacity(0.3))
                    
                    Text("GMT+14")
                        .font(.system(size: 8, weight: .regular))
                } //HStack
                
                HStack {
                    Spacer()
                        .frame(width: pickerVisualStaticSpacer())
                    
                    RoundedRectangle(cornerRadius: 1)
                        .frame(width: 2, height: 10)
                        .foregroundColor(.primary.opacity(0.3))
                    
                    Spacer()
                } //HStack
                .frame(width: 260)
                
                HStack {
                    Spacer()
                        .frame(width: pickerVisualMovingSpacer())
                    
                    RoundedRectangle(cornerRadius: 1)
                        .frame(width: 2, height: 10)
                        .foregroundColor(.primary)
                    
                    Spacer()
                } //HStack
                .frame(width: 260)
            } //ZStack
            
            if pickerHour == 0  {
                Text("현재 위치와 동일한 시간대의 주요 지역")
                    .font(.system(size: 14, weight: .regular))
                    .padding(.top, 10)
                    .padding(.bottom, 40)
            } else {
                Text("현재 위치보다 \(pickerHour)시간 \(pickerFastOrSlow[0]) 시간대의 주요 지역")
                    .font(.system(size: 14, weight: .regular))
                    .padding(.top, 10)
                    .padding(.bottom, 40)
            }
        }
    }
    
    var NationContentView: some View {
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
                            withAnimation(.spring(duration: 1.0)) {
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
            .frame(height: screenHeight * 0.18)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .bottom) {
                    Text(Date().currentLocalTime(tzOffset: selectPickerResult(selectedPicker: selectedPicker)))
                        .font(.system(size: 64, weight: .heavy))
                        .foregroundColor(.white)
                    Text("GMT\(showingTargetLocalGMT(selectedPicker: selectedPicker))")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.bottom, 16)
                }
                Text(Date().currentLocalDate(tzOffset: selectPickerResult(selectedPicker: selectedPicker)))
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.leading, 4)
            }
            .frame(height: 120)
            .padding(.bottom, 10)
            
            ScrollView {
                NationWrappingView(
                    pickerHour: $pickerHour,
                    pickerFastOrSlow: $pickerFastOrSlow,
                    selectedPicker: $selectedPicker
                )
            }
            .scrollIndicators(.hidden)
        }
    }
    
    private func pickerVisualMovingSpacer() -> CGFloat {
        let hour = calcTargetLocalGMT(selectedPicker: selectedPicker)
        
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
        let hour = calcCurrentLocalGMT()
        
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
    
    private var hourRange: ClosedRange<Int> {
        var wrappedGMT = calcCurrentLocalGMT() <= -11 ? -10 : calcCurrentLocalGMT()
        wrappedGMT = calcCurrentLocalGMT() >= 14 ? 13 : calcCurrentLocalGMT()
        
        if selectedPicker[0] == 0 {
            let min = 0
            let max = 14 - wrappedGMT
            
            return min...max
            
        } else {
            let min = 0
            let max = abs(-12 - wrappedGMT)
            
            return min...max
        }
    } // hourRange
} // struct
