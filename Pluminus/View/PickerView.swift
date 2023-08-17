//
//  PickerView.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/04.
//

import SwiftUI
import Combine

// 중앙 스택 뷰 (타임 피커 + 세계 시간)
struct PickerView: View {

    @StateObject var locationManager = MyLocationManager()

    @State private var dataSource: [[String]] = [["+","-"], []]
    @State private var pickerFastOrSlow: [String] = ["빠른", "+"]
    @State var pickerHour: Int = 0
    @State var targetTimeHour: String = "-"
    @State private var targetTimeMinute: String = "--"
    @State private var targetDate: String = "-월 -일 -요일"
    
    @Binding var selected: [Int]
    @Binding var currentUTC: Int
    @Binding var utcOffsetHours: Int
    @Binding var isPickerView: Bool
    @Binding var currentTimeHour: String
    @Binding var currentTimeMinute: String
    @Binding var targetTime: String
    
    init(utcOffsetHours: Binding<Int>, isPickerView: Binding<Bool>, currentTimeHour: Binding<String>, currentTimeMinute: Binding<String>, currentUTC: Binding<Int>, targetTime: Binding<String>, selected: Binding<[Int]>) {
        self._utcOffsetHours = utcOffsetHours
        self._isPickerView = isPickerView
        self._currentTimeHour = currentTimeHour
        self._currentTimeMinute = currentTimeMinute
        self._currentUTC = currentUTC
        self._targetTime = targetTime
        self._selected = selected
        
        _ = self.hourRange
    }
    
    func pickerResult() -> Int {
        let value = selected[1]
        return selected[0] == 1 ? -value : value
    }
    
    private var hourRange: ClosedRange<Int> {
        var wrappedUTC = currentUTC <= -11 ? -10 : currentUTC
        wrappedUTC = currentUTC >= 14 ? 13 : currentUTC
        
        if selected[0] == 0 {
            let min = 0
            let max = 14 - wrappedUTC
            
            return min...max
            
        } else {
            let min = 0
            let max = abs(-11 - wrappedUTC)
            
            return min...max
        }
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
                            _ = calcUTC()
                        }
                        .onChange(of: selected[1]) { newValue in
                            print(">>>>> PICKER OnChange(selected[1])")
                            pickerHour = newValue
                            _ = hourRange
                            dataSource[1] = Array(hourRange).map { String($0) }
                            _ = calcUTC()
                        }
                        .onChange(of: dataSource) { newValue in
                            print(">>>>> PICKER OnChange(dataSource)")
                            _ = hourRange
                            dataSource[1] = Array(hourRange).map { String($0) }
                        }
                        .onAppear(perform: {
                            print(">>>>> PICKER OnAppear")
                            _ = calcUTC()
                            _ = hourRange
                            dataSource[1] = Array(hourRange).map { String($0) }
                        })
                        .onDisappear {
                            print(">>>>> PICKER OnDisappear")
                            _ = calcUTC()
                            targetTime = targetTimeHour
                            _ = hourRange
                            dataSource[1] = Array(hourRange).map { String($0) }
                        }
                        
                    Text("시간")
                        .font(.system(size: 17, weight: .bold))
                } // HStack닫기
                
                Spacer()
                
                Text("현위치보다 \(pickerHour)시간 \(pickerFastOrSlow[0]) 주요 지역")
                    .font(.system(size: 15, weight: .medium))
                    .padding(.bottom, screenWidth * 0.04)
            } else {
                // 세계시간 뷰
                GeometryReader { geometry in
                    VStack(alignment: .leading) {
                        HStack(alignment: .bottom) {
                            // 시차 그래프
                            RoundedRectangle(cornerRadius: 2)
                                .fill(
                                    LinearGradient(gradient: Gradient(colors: [.white.opacity(0), .white.opacity(1)]),
                                                   startPoint: .top, endPoint: .bottom)
                                )
                                .frame(width: 2, height: calcRoundedRectangleHeight(pickerHour: pickerHour))
                                .padding(.leading, screenWidth * 0.13)
                            Text("\(pickerFastOrSlow[1]) \(pickerHour) 시간")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text(Date.currentTime(timeZoneOffset: pickerResult()))
                                    .font(.system(size: 64, weight: .heavy))
                                    .foregroundColor(.white)
                                    .padding(.leading, 20)
                                Text(Date.currentDate(timeZoneOffset: pickerResult()))
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.leading, 24)
                            }
                            .frame(height: 120)
                        }
                        
                        NationView(
                            targetTimeHour: $targetTimeHour,
                            targetTimeMinute: $targetTimeMinute,
                            targetDate: $targetDate,
                            pickerHour: $pickerHour,
                            pickerFastOrSlow: $pickerFastOrSlow, // 첫 번째 인덱스의 값을 바인딩
                            geometry: geometry,
                            targetUtcTime: calcUTC(),
                            calcUTC: calcUTC
                        )
                    } // VStack닫기
                } // GeometryReader닫기
            } // if닫기
        } //VStack닫기
        .onReceive(Just(dataSource)) { newValue in
            _ = hourRange
            dataSource[1] = Array(hourRange).map { String($0) }
        }
    } // body닫기
    
    // 세계시간 뷰 시차 그래프의 높이를 동적으로 변환해주는 메서드
    private func calcRoundedRectangleHeight(pickerHour: Int) -> CGFloat {
        let minHeight: CGFloat = screenHeight * 0.02
        let maxHeight: CGFloat = screenHeight * 0.19
        let hourRange: ClosedRange<Int> = 0...23
        
        let normalizedHour = CGFloat(pickerHour - hourRange.lowerBound) / CGFloat(hourRange.upperBound - hourRange.lowerBound)
        
        let calculatedHeight = minHeight + (maxHeight - minHeight) * normalizedHour
        
        return calculatedHeight
    }
    
    // 타임 피커와 UTC간 시차 계산 메서드
    func calcUTC() -> Int {
        print("ㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜ")
        print(">>> run : calcUTC method")

        let date = Date.now
        let targetUTC: Int
        
        if pickerFastOrSlow[0] == "빠른" {
            targetUTC = locationManager.currentLocationUTC + pickerHour
        } else {
            targetUTC = locationManager.currentLocationUTC - pickerHour
        }
        
        // targetUtcTime값에 따라 targetTime을 업데이트
        let formatter = DateFormatter()
        let offsetSeconds = targetUTC * 3600 // 시간 차이를 초 단위로 변환
        let timeZone = TimeZone(secondsFromGMT: offsetSeconds)
        formatter.timeZone = timeZone
        formatter.locale = Locale(identifier: "ko_KR")
        
        // 타겟 시간 관련 포맷
        formatter.dateFormat = "HH"
        let targetTimeHour = formatter.string(from: date)
        targetTime = targetTimeHour
        formatter.dateFormat = "mm"
        let targetTimeMinute = formatter.string(from: date)
        
        print("> TARGET HH:mm :",targetTimeHour, ":", targetTimeMinute)
        
        // 타겟 날짜 관련 포맷
        formatter.dateFormat = "M월 d일 E요일"
        let targetDate = formatter.string(from: date)
        
        DispatchQueue.main.async {
            self.targetTimeHour = targetTimeHour
            self.targetTimeMinute = targetTimeMinute
            self.targetDate = targetDate
        }
        
        print("> UTC Time Calc: \(locationManager.currentLocationUTC) \(pickerFastOrSlow[1]) \(pickerHour) = \(targetUTC)")
        print("> TARGET DATE :",targetDate)
        print("ㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗ")
        
        return targetUTC
    } // calcUTC 메서드 닫기
} // struct닫기

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(
            utcOffsetHours: .constant(locationManager.currentLocationUTC),
            isPickerView: .constant(true),
            currentTimeHour: .constant("--"),
            currentTimeMinute: .constant("--"),
            currentUTC: .constant(0),
            targetTime: .constant("--"),
            selected: .constant([0, 0])
        )
    }
}
