//
//  MainView.swift
//  NC1
//  Created by kimsangwoo on 2023/06/01.
//
//

import SwiftUI

struct MainView: View {

    @State private var currentLocationName: String = ""
    @State private var isPickerView : Bool = true
    @State private var selected: [Int] = [0, 0]
    
    var body: some View {
        ZStack {
            BackColorView(
                isPickerView: $isPickerView,
                selected: $selected
            )
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(Date.currentTime(timeZoneOffset: 0))
                            .font(.system(size: 64, weight: isPickerView ? .heavy : .thin))
                            .foregroundColor(isPickerView ? .primary : .white)
                            .padding(.leading, 20)
                        Text(Date.currentDate(timeZoneOffset: 0))
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(isPickerView ? .primary : .white)
                            .padding(.leading, 24)
                    }
                    .frame(height: 120)
                    
                    Spacer()
                }
                
                // 현재 위치
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
                
                PickerView(
                    isPickerView: $isPickerView,
                    selected: $selected
                )
                Button(action: {
                    HapticManager.instance.notification(type: .success)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isPickerView.toggle()
                        }
                    }
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 35)
                            .frame(width: isPickerView ? 300 : 350, height: 70)
                            .foregroundColor(isPickerView ? .orange : .black.opacity(0.3))
                        Text(isPickerView ? "확인해보기" : "돌아가기")
                            .foregroundColor(.white)
                            .font(.system(size: 17, weight: .black))
                    }
                    .padding(.bottom, 30)
                }) // Button닫기
            } // VStack닫기
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
