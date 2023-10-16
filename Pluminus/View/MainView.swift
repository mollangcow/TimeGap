//
//  MainView.swift
//  NC1
//  Created by kimsangwoo on 2023/06/01.
//
//

import SwiftUI

struct MainView: View {

    @State private var currentLocationName : String = ""
    @State private var isPickerView : Bool = true
    @State private var selected : [Int] = [0, 0]
    @State private var isShowingSetting : Bool = false
    
    var body: some View {
        ZStack {
            //시간대에 달라지는 배경 색상
            BackColorView(
                isPickerView: $isPickerView,
                selected: $selected
            )
            
            VStack {
                HStack(alignment: .top) {
                    // 현재 위치 시간
                    VStack(alignment: .leading) {
                        Text(Date.currentTime(timeZoneOffset: 0))
                            .font(.system(size: 64, weight: isPickerView ? .heavy : .thin))
                            .foregroundColor(isPickerView ? .primary : .white)
                            .padding(.leading, 20)
                        Text(Date.currentDate(timeZoneOffset: 0))
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(isPickerView ? .primary : .white)
                            .padding(.leading, 24)
                    } //HStack닫기
                    .frame(height: 120)
                    
                    Spacer()
                    
                    if isPickerView {
                        Button(action: {
                            HapticManager.instance.impact(style: .light)
                            isShowingSetting = true
                        }, label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 44, height: 44)
                                    .foregroundStyle(.clear)
                                
                                Image(systemName: "gearshape.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(.gray.opacity(0.4))
                            }
                            .padding(.top, 20)
                            .padding(.trailing, 10)
                        })
                    }
                } //VStack닫기
                
                // 현재 위치 표기
                HStack {
                    Spacer()
                    
                    Image(isPickerView ? "locationPin.orange" : "locationPin.white")
                        .resizable()
                        .frame(width: 15, height: 19)
                    Text(currentLocationName)
                        .font(.system(size: 20, weight: .heavy))
                        .foregroundColor(isPickerView ? .primary : .white)
                        .padding(.trailing, 20)
                } // HStack닫기
                
                Spacer()
                
                // 중앙 커스텀 피커
                PickerView(
                    isPickerView: $isPickerView,
                    selected: $selected
                )
                
                // 하단 버튼
                Button(action: {
                    HapticManager.instance.notification(type: .warning)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.spring) {
                            isPickerView.toggle()
                        }
                    }
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 35)
                            .frame(width: isPickerView ? 260 : 350, height: 70)
                            .foregroundColor(isPickerView ? .orange : .black.opacity(0.3))
                        if isPickerView {
                            Text("확인해보기")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .black))
                        } else {
                            Text("돌아가기")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .black))
                        }
                    }
                    .padding(.bottom, 30)
                }) // Button닫기
            } // VStack닫기
            .sheet(isPresented: $isShowingSetting) {
                SettingView()
            }
            .onReceive(locationManager.$currentLocationName) { newLocation in
                self.currentLocationName = newLocation
            }
        } // ZStack닫기
        .statusBarHidden()
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
