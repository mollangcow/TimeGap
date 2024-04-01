//
//  LocalityDetailView.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/06.
//

import SwiftUI

struct NationDetailView: View {
    @State private var isShowingMap: Bool = false
    @State private var tappedLocality: String = ""
    @State private var rectangleHeight: CGFloat = 0
    @State var currentCountryList: [String] = []
    
    @Binding var countryName: String
    @Binding var continent: String
    @Binding var pickerFastOrSlow: [String]
    @Binding var pickerHour: Int
    @Binding var selectedPicker: [Int]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                HapticManager.instance.impact(style: .light)
                dismiss()
            }, label: {
                RoundedRectangle(cornerRadius: 3)
                    .frame(width: 40, height: 6)
                    .foregroundStyle(.gray.opacity(0.5))
                    .padding(.all, 20)
                    .background(.clear)
            })
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text(countryName)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.leading, 2)
                    
                    Text(continent)
                        .font(.system(size: 12, weight: .light))
                        .foregroundColor(.white)
                        .padding(.leading, 2)
                    
                    Spacer()
                    
                    Text(Date().currentTime(timeZoneOffset: pickerResult(selectedPicker: selectedPicker)))
                        .font(.system(size: 52, weight: .heavy))
                        .foregroundColor(.white)
                    
                    Text(Date().currentDate(timeZoneOffset: pickerResult(selectedPicker: selectedPicker)))
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
                    .frame(width: 2, height: rectangleHeight)
                    .onAppear {
                        withAnimation(.spring(duration: 2.0)) {
                            rectangleHeight = 120
                        }
                    }
                    .onDisappear {
                        rectangleHeight = 1
                    }
            } //HStack
            .padding(.all, 20)
            .frame(width: screenWidth * 0.88, height: 160)
            .background(
                getBackgroundColor(targetHourResult: targetHourResult(selectedPicker: selectedPicker))
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))

            Text("\(countryName)에서 이 시간대에 해당하는 주요 지역")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.primary)
                .frame(width: screenWidth * 0.8, alignment: .leading)
                .padding(.top, 30)

            Divider()
                .foregroundColor(.clear)
                .frame(width: screenWidth * 0.88)
                .background(Color.gray.opacity(0.3))
                .padding(.top, 10)

            ScrollView(.vertical) {
                ForEach(currentCountryList, id: \.self) { locality in
                    Button(action: {
                        HapticManager.instance.impact(style: .rigid)
                        showLocalityMap(isShowingMap: true, countryLocality: locality)
                    }, label: {
                        HStack {
                            Text(locality)
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(Color.primary)
                                .padding(.leading, 20)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.secondary)
                                .padding(.trailing, 20)
                        }
                        .frame(width: screenWidth * 0.88, height: 60, alignment: .leading)
                        .background(.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    })
                    .padding(.top, 4)
                }
                .padding(.top, 10)
                .padding(.bottom, 50)
            }
            .scrollIndicators(.hidden)
        } // VStack닫기
        .onAppear {
            currentCountryList = CountryList.list.GMT[gmtTargetResult(selectedPicker: selectedPicker)]?.first { country in
                country.countryName == self.countryName
            }?.countryLocality ?? []
        }
        .sheet(isPresented: $isShowingMap) {
            NationInfoMapView(
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
