//
//  LocalityDetailView.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/06.
//

import SwiftUI

struct LocalityDetailView: View {
    
    @State var currentCountryList: [String] = []
    
    @Binding var countryName: String
    @Binding var pickerFastOrSlow: [String]
    @Binding var pickerHour: Int
    @Binding var selected: [Int]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 200)
                    .background(
                        getBackgroundColor(targetHourResult: targetHourResult())
                    )
                VStack(alignment: .leading) {
                    HStack {
                        Text(countryName)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white.opacity(0.2))
                        })
                    }
                    .padding(.trailing, 30)
                    Rectangle()
                        .frame(width: 50, height: 2)
                        .foregroundColor(.white.opacity(0.2))
                        .padding(.leading, 2)
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            Text(Date.currentTime(timeZoneOffset: pickerResult()))
                                .font(.system(size: 52, weight: .heavy))
                                .foregroundColor(.white)
                            Text(Date.currentDate(timeZoneOffset: pickerResult()))
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.white)
                                .padding(.leading, 2)
                        }

                        Spacer()

                        Text("\(pickerFastOrSlow[1]) \(pickerHour) 시간")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
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
                                    endPoint: .bottom
                                )
                            )
                            .frame(width: 2, height : 70)
                    }
                    .padding(.top, 20)
                    .padding(.trailing, 40)
                }
                .padding(.leading, 40)
            }
            .edgesIgnoringSafeArea(.top)

            Text("\(countryName)에서 이 시간대에 해당하는 주요 지역")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.gray)
                .frame(width: screenWidth * 0.8, alignment: .leading)
                .padding(.top, 20)

            Divider()
                .padding(.top, 10)
                .frame(width: screenWidth * 0.8)

            ScrollView(.vertical) {
                ForEach(currentCountryList, id: \.self) { locality in
                    Text(locality)
                        .frame(width: screenWidth * 0.8, alignment: .leading)
                        .padding(.top, 30)
                        .font(.system(size: 20, weight: .bold))
                }
            }
            .scrollIndicators(.hidden)
        } // VStack닫기
        .onAppear {
            currentCountryList = CountryList.list.UTC[gmtTargetResult()]?.first{ country in
                country.countryName == self.countryName
            }?.countryLocality ?? []
        }
    } // body닫기
    
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
    
    func targetHourResult() -> Int {
        let formattedString = Date.currentTime(timeZoneOffset: pickerResult())
        
        if let range = formattedString.range(of: "^(\\d+):", options: .regularExpression),
           let timeOffset = Int(formattedString[range].dropLast()) {
            return timeOffset
        }
        
        return 0
    }
} // struct닫기
