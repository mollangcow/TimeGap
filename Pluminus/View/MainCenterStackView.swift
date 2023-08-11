//
//  MainPickerView.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/04.
//

import SwiftUI
import Combine

// 중앙 스택 뷰 (타임 피커 + 세계 시간)
struct MainCenterStackView: View {

    @StateObject var locationManager = MyLocationManager()

    @State private var dataSource: [[String]] = [["+","-"], []]
    @State private var pickerFastOrSlow: [String] = ["빠른", "+"]
    @State private var pickerHour: Int = 0
    @State var targetTimeHour: String = "-"
    @State private var targetTimeMinute: String = "--"
    @State private var targetDate: String = "-월 -일 -요일"
    
    @Binding var selected: [Int]
    @Binding var currentUTC: Int
    @Binding var utcOffsetHours: Int
    @Binding var isShowingMainCenterStackView: Bool
    @Binding var currentTimeHour: String
    @Binding var currentTimeMinute: String
    @Binding var targetTime: String
    
    init(utcOffsetHours: Binding<Int>, isShowingMainCenterStackView: Binding<Bool>, currentTimeHour: Binding<String>, currentTimeMinute: Binding<String>, currentUTC: Binding<Int>, targetTime: Binding<String>, selected: Binding<[Int]>) {
        self._utcOffsetHours = utcOffsetHours
        self._isShowingMainCenterStackView = isShowingMainCenterStackView
        self._currentTimeHour = currentTimeHour
        self._currentTimeMinute = currentTimeMinute
        self._currentUTC = currentUTC
        self._targetTime = targetTime
        self._selected = selected
        
        _ = self.hourRange
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
            if isShowingMainCenterStackView {
                // 메인 피커 뷰
                Spacer()
                HStack {
                    // 타임 피커 로직
                    MulticomponentPicker(dataSource: $dataSource, selected: $selected)
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
                // 타임 피커 가이딩 텍스트
                Text("현위치보다 \(pickerHour)시간 \(pickerFastOrSlow[0]) 주요 지역")
                    .font(.system(size: 15, weight: .medium))
                    .padding(.bottom, UIScreen.main.bounds.width * 0.04)
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
                                .padding(.leading, UIScreen.main.bounds.width * 0.13)
                            Text("\(pickerFastOrSlow[1]) \(pickerHour) 시간")
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                        }
                        Spacer()
                        // 타겟 시간대의 시계
                        Text("\(targetTimeHour):\(targetTimeMinute)")
                            .font(.system(size: 64, weight: .heavy))
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .foregroundColor(.white)
                            .padding(.leading, UIScreen.main.bounds.width * 0.06)
                        Text(targetDate)
                            .font(.system(size: 17, weight: .semibold))
                            .frame(width: UIScreen.main.bounds.width, alignment: .leading)
                            .foregroundColor(.white)
                            .padding(.leading, UIScreen.main.bounds.width * 0.08)
                            .padding(.bottom, UIScreen.main.bounds.height * 0.25)
                    } // VStack닫기
                    // 하단 국가 태그 리스트
                    VStack {
                        ClockViewBottomCountryTagStackView(
                            targetTimeHour: $targetTimeHour,
                            targetTimeMinute: $targetTimeMinute,
                            targetDate: $targetDate,
                            pickerHour: $pickerHour,
                            pickerFastOrSlow: $pickerFastOrSlow, // 첫 번째 인덱스의 값을 바인딩
                            geometry: geometry,
                            targetUtcTime: calcUTC(),
                            calcUTC: calcUTC
                        )
                        .padding(.top, UIScreen.main.bounds.height * 0.34)
                    } // VStack닫기
                } // GeometryReader닫기
            } // if닫기
        } //VStack닫기
        .frame(width: UIScreen.main.bounds.width)
        .onReceive(Just(dataSource)) { newValue in
            _ = hourRange
            dataSource[1] = Array(hourRange).map { String($0) }
        }
    } // body닫기
    
    // 세계시간 뷰 시차 그래프의 높이를 동적으로 변환해주는 메서드
    private func calcRoundedRectangleHeight(pickerHour: Int) -> CGFloat {
        let minHeight: CGFloat = UIScreen.main.bounds.height * 0.02
        let maxHeight: CGFloat = UIScreen.main.bounds.height * 0.19
        let hourRange: ClosedRange<Int> = 0...23
        
        let normalizedHour = CGFloat(pickerHour - hourRange.lowerBound) / CGFloat(hourRange.upperBound - hourRange.lowerBound)
        
        let calculatedHeight = minHeight + (maxHeight - minHeight) * normalizedHour
        
        return calculatedHeight
    }
    
    // 타임 피커와 UTC간 시차 계산 메서드
    func calcUTC() -> Int {
        let date = Date()
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
        
        // 타겟 날짜 관련 포맷
        formatter.dateFormat = "M월 d일 E요일"
        let targetDate = formatter.string(from: date)
        
        DispatchQueue.main.async {
            self.targetTimeHour = targetTimeHour
            self.targetTimeMinute = targetTimeMinute
            self.targetDate = targetDate
        }
        
        // 현재 위치의 시간과 피커 시간을 계산하여 타겟 세계시간의 UTC값을 알려주는 리턴값
        print("ㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜ")
        print("UTC Time Calc: \(locationManager.currentLocationUTC) \(pickerFastOrSlow[1]) \(pickerHour) = \(targetUTC)")
        print("TARGET HH:mm :",targetTimeHour, ":", targetTimeMinute)
        print("TARGET DATE :",targetDate)
        print("ㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗㅗ")
        
        return targetUTC
    } // calcUTC 메서드 닫기
} // struct닫기

// 세계시간 뷰 하단 나라 구름 스택 뷰
struct ClockViewBottomCountryTagStackView: View {
    
    @State private var isShowingModal: Bool = false
    @State private var tappedCountry: String = ""
    
    @Binding var targetTimeHour: String
    @Binding var targetTimeMinute: String
    @Binding var targetDate: String
    @Binding var pickerHour: Int
    @Binding var pickerFastOrSlow: [String]
    
    let geometry: GeometryProxy
    let targetUtcTime: Int
    
    let calcUTC: () -> Int
    
    var body: some View {
        VStack{
            if let countries = CountryList.list.UTC[targetUtcTime] {
                generateContent(in: geometry, countries: countries)
            } else {
                // targetUtcTime이 nil일 때 처리할 내용
                Spacer()
                Text("다시 시도해주세요.")
                    .font(.system(size: 17, weight: .black))
                    .frame(width: UIScreen.main.bounds.width)
                    .foregroundColor(.white)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.1)
            }
        } // VStack닫기
        .sheet(isPresented: $isShowingModal) {
            LocalityModalView(
                targetTimeHour: $targetTimeHour,
                targetTimeMinute : $targetTimeMinute,
                targetDate: $targetDate,
                countryName: $tappedCountry,
                pickerHour: $pickerHour,
                pickerFastOrSlow: $pickerFastOrSlow,
                targetUtcTime: targetUtcTime
            )
        } //sheet닫기
    } // body닫기
    private func showLocality(isShowingModal: Bool, countryName: String) {
        if isShowingModal {
            self.isShowingModal = true
            self.tappedCountry = countryName
        }
    }
    private func generateContent(in g: GeometryProxy, countries: [Country]) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(CountryList.list.UTC[targetUtcTime]!, id: \.self) { tag in
                Button {
                    showLocality(isShowingModal: tag.isHaveLocality, countryName: tag.countryName)
                    pickerHour = self.pickerHour
                    pickerFastOrSlow = self.pickerFastOrSlow
                } label: {
                    ZStack {
                        HStack {
                            Text(tag.countryName)
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.black)
                                .padding(.trailing, 4)
                            if tag.isHaveLocality {
                                Image(systemName: "ellipsis.circle.fill")
                                    .foregroundColor(.orange)
                                    .opacity(0)
                                    .overlay(
                                        Image(systemName: "ellipsis.circle.fill")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(.orange)
                                    )
                            } // if닫기
                        } // HStack닫기
                        .padding(.horizontal, 18)
                        .padding(.vertical, 12)
                        .background(.white)
                        .cornerRadius(32)
                    } // ZStack닫기
                } // Button닫기
                .padding([.horizontal], 4)
                .padding([.vertical], 8)
                .alignmentGuide(.leading, computeValue: { d in
                    if (abs(width - d.width - 8) > g.size.width)
                    {
                        width = 0
                        height -= d.height
                    }
                    let result = width
                    if tag == CountryList.list.UTC[targetUtcTime]!.first! {
                        width = 0 //last item
                    } else {
                        width -= d.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: {d in
                    let result = height
                    if tag == CountryList.list.UTC[targetUtcTime]!.first! {
                        height = 0 // last item
                    }
                    return result
                })
            } // ForEach닫기
        } // ZStack닫기
        .padding(.leading, UIScreen.main.bounds.width * 0.05)
    } // func닫기
} // struct닫기

struct MainCenterStackView_Previews: PreviewProvider {
    static var previews: some View {
        MainCenterStackView(
            utcOffsetHours: .constant(locationManager.currentLocationUTC),
            isShowingMainCenterStackView: .constant(true),
            currentTimeHour: .constant("--"),
            currentTimeMinute: .constant("--"),
            currentUTC: .constant(0),
            targetTime: .constant("--"),
            selected: .constant([0, 0])
        )
    }
}
