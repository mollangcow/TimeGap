//
//  LocalityModalView.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/06.
//

import SwiftUI

struct LocalityModalView: View {
    
    @Binding var targetTimeHour: String
    @Binding var targetTimeMinute: String
    @Binding var targetDate: String
    @Binding var countryName: String
    @Binding var pickerFastOrSlow: [String]
    @Binding var pickerHour: Int
    
    @State var currentCountryList: [String] = []
    var targetUtcTime: Int
    
    init(targetTimeHour: Binding<String>,targetTimeMinute: Binding<String>, targetDate: Binding<String>, countryName: Binding<String>, pickerHour: Binding<Int>, pickerFastOrSlow: Binding<[String]>, targetUtcTime: Int) {
        self._targetTimeHour = targetTimeHour
        self._targetTimeMinute = targetTimeMinute
        self._targetDate = targetDate
        self._countryName = countryName
        self._pickerHour = pickerHour
        self._pickerFastOrSlow = pickerFastOrSlow
        self.targetUtcTime = targetUtcTime
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: screenWidth * 0.9, height: screenHeight * 0.13)
                        .padding(.top, screenHeight * 0.02)
                        .foregroundColor(
                            getBackgroundColor()
                        )
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            Text("\(targetTimeHour):\(targetTimeMinute)")
                                .font(.system(size: 42, weight: .heavy))
                                .foregroundColor(.white)
                            Text(self.targetDate)
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(width: screenWidth * 0.57, alignment: .leading)
                        .padding(.top, screenHeight * 0.01)
                        Text("\(pickerFastOrSlow[1]) \(pickerHour) 시간")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                        RoundedRectangle(cornerRadius: 2)
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [.white.opacity(0), .white.opacity(1)]),
                                               startPoint: .top, endPoint: .bottom)
                            )
                            .frame(width: 2, height : screenHeight * 0.07)
                    }
                }
                
                Text("\(countryName)에서 이 시간대에 해당하는 주요 지역")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.gray)
                    .frame(width: screenWidth * 0.8, alignment: .leading)
                    .padding(.top, screenHeight * 0.03)
                
                Divider()
                    .padding(.top, screenHeight * 0.01)
                    .frame(width: screenWidth * 0.8)
                
                // 도시 리스트 출력 스크롤뷰
                ScrollView(.vertical) {
                    ForEach(currentCountryList, id: \.self) { locality in
                        Text(locality)
                            .frame(width: screenWidth * 0.8, alignment: .leading)
                            .padding(.top, screenWidth * 0.05)
                            .font(.system(size: 20, weight: .bold))
                    }
                }
                .scrollIndicators(.hidden)
            } // VStack닫기
            .onAppear {
                currentCountryList = CountryList.list.UTC[targetUtcTime]?.first{ country in
                    country.countryName == self.countryName
                }?.countryLocality ?? []
            }
            .onChange(of: targetTimeHour) { newValue in
                targetTimeHour = newValue
            }
            .toolbar {
                ToolbarItem {
                    VStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 40, height: 6)
                            .foregroundColor(.primary)
                            .opacity(0.2)
                        Text(countryName)
                            .frame(width: screenWidth, alignment: .center)
                            .font(.system(size: 17, weight: .bold))
                    }
                }
            } // toolBar닫기
        } // NavigationView닫기
    } // body닫기
    
    func getBackgroundColor() -> Color {
        if targetTimeHour == "05" || targetTimeHour == "06" {
            return Color.G0506_Top
        }
        else if targetTimeHour == "07" || targetTimeHour == "08" {
            return Color.G0708_Top
        }
        else if targetTimeHour == "09" || targetTimeHour == "10" {
            return Color.G0910_Top
        }
        else if targetTimeHour == "11" || targetTimeHour == "12" {
            return Color.G1112_Top
        }
        else if targetTimeHour == "13" || targetTimeHour == "14" {
            return Color.G1314_Top
        }
        else if targetTimeHour == "15" || targetTimeHour == "16" {
            return Color.G1516_Top
        }
        else if targetTimeHour == "17" || targetTimeHour == "18" {
            return Color.G1718_Top
        }
        else if targetTimeHour == "19" || targetTimeHour == "20" {
            return Color.G1920_Top
        }
        else if targetTimeHour == "21" || targetTimeHour == "22" {
            return Color.G2122_Top
        }
        else if targetTimeHour == "23" || targetTimeHour == "00" {
            return Color.G2300_Top
        }
        else if targetTimeHour == "01" || targetTimeHour == "02" {
            return Color.G0102_Top
        }
        else if targetTimeHour == "03" || targetTimeHour == "04" {
            return Color.G0304_Top
        }
        else {
            return Color.primary
        }
    } // func닫기
} // struct닫기

struct LocalityModalView_Previews: PreviewProvider {
    static var previews: some View {
        LocalityModalView(
            targetTimeHour: .constant("-"),
            targetTimeMinute: .constant("--"),
            targetDate: .constant("-월 -일 -요일"),
            countryName: .constant("국가명"),
            pickerHour: .constant(0),
            pickerFastOrSlow: .constant(["빠른", "+"]),
            targetUtcTime: 0
        )
    }
}
