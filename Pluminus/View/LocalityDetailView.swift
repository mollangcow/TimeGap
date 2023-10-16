//
//  LocalityDetailView.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/06.
//

import SwiftUI

struct LocalityDetailView: View {
    
    @State private var isShowingMap: Bool = false
    @State private var tappedLocality: String = ""
    @State var currentCountryList: [String] = []
    
    @Binding var countryName: String
    @Binding var continent: String
    @Binding var pickerFastOrSlow: [String]
    @Binding var pickerHour: Int
    @Binding var selected: [Int]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                HapticManager.instance.impact(style: .light)
                dismiss()
            }, label: {
                ZStack {
                    Rectangle()
                        .frame(width: 60, height: 46)
                        .foregroundStyle(.clear)
                    
                    RoundedRectangle(cornerRadius: 3)
                        .frame(width: 40, height: 6)
                        .foregroundStyle(.gray.opacity(0.5))
                }
            })
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.clear)
                    .frame(width: screenWidth * 0.92, height: 200)
                    .background(
                        getBackgroundColor(targetHourResult: targetHourResult(selected: selected))
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text(countryName)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.leading, 2)
                        
                        Text(continent)
                            .font(.system(size: 17, weight: .light))
                            .foregroundColor(.white)
                            .padding(.leading, 2)
                        
                        Spacer()
                        
                        Text(Date.currentTime(timeZoneOffset: pickerResult(selected: selected)))
                            .font(.system(size: 52, weight: .heavy))
                            .foregroundColor(.white)
                        
                        Text(Date.currentDate(timeZoneOffset: pickerResult(selected: selected)))
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.leading, 2)
                    } //VStack
                    
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
                        .frame(width: 2, height : 160)
                } //HStack
                .frame(width: screenWidth * 0.8, height: 160)
            } //ZStack

            Text("\(countryName)에서 이 시간대에 해당하는 주요 지역")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.primary)
                .frame(width: screenWidth * 0.8, alignment: .leading)
                .padding(.top, 30)

            Divider()
                .frame(width: screenWidth * 0.9)
                .background(Color.gray)
                .padding(.top, 10)

            ScrollView(.vertical) {
                ForEach(currentCountryList, id: \.self) { locality in
                    Button(action: {
                        HapticManager.instance.impact(style: .rigid)
                        showLocalityMap(isShowingMap: true, countryLocality: locality)
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: screenWidth * 0.9, height: 60)
                                .foregroundStyle(.gray.opacity(0.1))
                            Text(locality)
                                .frame(width: screenWidth * 0.8, alignment: .leading)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.primary)
                        }
                    })
                    .padding(.top, 4)
                }
                .padding(.top, 10)
                .padding(.bottom, 50)
            }
            .scrollIndicators(.hidden)
        } // VStack닫기
        .onAppear {
            currentCountryList = CountryList.list.GMT[gmtTargetResult(selected: selected)]?.first { country in
                country.countryName == self.countryName
            }?.countryLocality ?? []
        }
        .sheet(isPresented: $isShowingMap) {
            MapView(
                countryName: $countryName,
                continent: $continent,
                locality: $tappedLocality
            )
        }
    } // body닫기
    
    private func showLocalityMap(isShowingMap: Bool, countryLocality: String) {
        if isShowingMap {
            self.isShowingMap = true
            self.tappedLocality = countryLocality
        }
    }
} // struct닫기
