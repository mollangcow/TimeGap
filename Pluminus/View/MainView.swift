//
//  MainView.swift
//  NC1
//  Created by kimsangwoo on 2023/06/01.
//
//

import SwiftUI
import SwiftUIVisualEffects

struct MainView: View {
    
    @State private var currentTimeHour: String = ""
    @State private var currentTimeMinute: String = ""
    @State private var currentDate: String = ""
    @State private var currentLocationName: String = ""
    @State private var isCenterContentView : Bool = true
    @State private var utcOffsetHours: Int = 0
    @State private var targetTimeHour: String = ""
    @State private var currentUTC: Int = 0
    @State var targetTime: String = ""
    @State var selected: [Int] = [0, 0]
    
    var body: some View {
        ZStack {
            BackColorView(
                isCenterContentView: $isCenterContentView,
                targetTimeHour: $targetTime
            )
            .onChange(of: targetTime) { newValue in
                targetTime = newValue
            }
            
            VStack {
                // 현재 위치 기반 현재 시간과 날짜
                Text("\(currentTimeHour):\(currentTimeMinute)")
                    .font(.system(size: 64, weight: isCenterContentView ? .heavy : .thin))
                    .foregroundColor(isCenterContentView ? .primary : .white)
                    .frame(width: screenWidth, alignment: .leading)
                    .padding(.leading, screenWidth * 0.12)
                    .padding(.top, screenWidth * 0.05)
                Text(currentDate)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(isCenterContentView ? .primary : .white)
                    .frame(width: screenWidth, alignment: .leading)
                    .padding(.leading, screenWidth * 0.15)
                
                // 현재 위치
                HStack {
                    Image(isCenterContentView ? "locationPin.orange" : "locationPin.white")
                        .resizable()
                        .frame(width: 15, height: 19)
                    Text(currentLocationName)
                        .font(.system(size: 20, weight: .heavy))
                        .foregroundColor(isCenterContentView ? .primary : .white)
                } // HStack닫기
                .frame(width: screenWidth, alignment: .trailing)
                .padding(.trailing, screenWidth * 0.12)
                .padding(.top, screenWidth * 0.03)
                
                Spacer()
                
                // 타임 피커 뷰
                PickerView(
                    utcOffsetHours: $utcOffsetHours,
                    isShowingMainCenterStackView: $isCenterContentView,
                    currentTimeHour: $currentTimeHour,
                    currentTimeMinute: $currentTimeMinute,
                    currentUTC: $currentUTC,
                    targetTime: $targetTime,
                    selected: $selected
                )
                
                // 세계 시간 확인 토글 버튼
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.7)) {
                        isCenterContentView.toggle()
                        }
                        print("ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ")
                        print("SHOWING PICKER VIEW :", isCenterContentView)
                        print("ㅛㅛㅛㅛㅛㅛㅛㅛㅛㅛ")
                }, label: {
                    Text(isCenterContentView ? "확인해보기" : "돌아가기")
                        .foregroundColor(.white)
                        .font(.system(size: 17, weight: .black))
                        .frame(
                            width: isCenterContentView ? screenWidth * 0.7 : screenWidth * 0.92,
                            height: 70
                        )
                        .background(
                            isCenterContentView ? .orange : .black)
                        .cornerRadius(35)
                }) // Button닫기
                .onChange(of: targetTime) { newValue in
                    targetTimeHour = newValue
                }
                .padding(.bottom, screenWidth * 0.03)
            } // VStack닫기
            
            // 위치 기반 현재 시간 받기
            .onReceive(locationManager.$date) { newDate in
                self.currentTimeHour = dateToString(date: newDate, dateFormat: "HH")
                self.currentTimeMinute = dateToString(date: newDate, dateFormat: "mm")
                self.currentDate = dateToString(date: newDate, dateFormat: "M월 d일 E요일")
                self.currentUTC = locationManager.currentLocationUTC
            }
            
            // 위치 기반 지역명 받기
            .onReceive(locationManager.$currentLocationName) { newLocation in
                self.currentLocationName = newLocation
            }
        } // ZStack닫기
    } // body닫기
} // struct닫기


func dateToString(date: Date, dateFormat: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    dateFormatter.locale = Locale(identifier: "ko_KR")
    let formattedTime = dateFormatter.string(from: date)
    return formattedTime
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
