//
//  LocalityDetailView.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/06.
//

import SwiftUI

struct NationDetailView: View {
    @State private var isShowingMap: Bool = false
    @State private var rectangleHeight: CGFloat = 0
    @State var currentCountryList: [String] = []
    
    @State private var tappedLocality: String = ""
    
    @Binding var countryName: String
    @Binding var continent: String
    @Binding var pickerFastOrSlow: [String]
    @Binding var pickerHour: Int
    @Binding var selectedPicker: [Int]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // banner
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
                    
                    Text(Date().currentLocalTime(tzOffset: selectPickerResult(selectedPicker: selectedPicker)))
                        .font(.system(size: 52, weight: .heavy))
                        .foregroundColor(.white)
                    
                    Text(Date().currentLocalDate(tzOffset: selectPickerResult(selectedPicker: selectedPicker)))
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.leading, 2)
                } // VStack
                
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
            } // HStack
            .padding(.all, 20)
            .frame(height: 160)
            .background(
                getBackgroundColor(targetLocalTimeHH: calcTargetLocalTimeHH(selectedPicker: selectedPicker))
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.vertical, 20)
            
            Text("\(countryName)에서 이 시간대에 해당하는 주요 지역")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.primary)
                .padding(.bottom, 12)

            Divider()
                .foregroundColor(.clear)
                .background(Color.gray.opacity(0.3))

            ScrollView(.vertical) {
                ForEach(currentCountryList, id: \.self) { locality in
                    Button {
                        HapticManager.instance.impact(style: .rigid)
                        showLocalityMap(isShowingMap: true, countryLocality: locality)
                    } label: {
                        HStack {
                            if !locality.isEmpty {
                                Text(locality)
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(Color.primary)
                                    .padding(.leading, 20)
                            } else {
                                Text(countryName)
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(Color.primary)
                                    .padding(.leading, 20)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(Color.orange)
                                .bold()
                                .padding(.trailing, 20)
                        }
                        .frame(height: 60)
                        .background(.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .padding(.top, 4)
                }
                .padding(.top, 10)
                .padding(.bottom, 50)
            }
            .scrollIndicators(.hidden)
        } // VStack닫기
        .padding(.horizontal, 20)
        .onAppear {
            currentCountryList = CountryList.list.GMT[calcTargetLocalGMT(selectedPicker: selectedPicker)]?.first { country in
                country.countryName == self.countryName
            }?.countryLocality ?? []
            
            print("aaaaaaaaaaaaaaaaaaaa : \(continent)")
            print("aaaaaaaaaaaaaaaaaaaa : \(countryName)")
        }
        .sheet(isPresented: $isShowingMap) {
            NationInfoMapView(
                countryName: $countryName,
                continent: $continent,
                locality: $tappedLocality
            )
            .presentationDetents([.large])
            .presentationCornerRadius(32)
        }
    } // body닫기
    
    private func showLocalityMap(isShowingMap: Bool, countryLocality: String) {
        if isShowingMap {
            self.isShowingMap = true
            self.tappedLocality = countryLocality
        }
    }
} // struct닫기
