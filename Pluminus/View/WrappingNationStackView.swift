//
//  NationView.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/17.
//

import SwiftUI
import WrappingHStack

struct WrappingNationStackView: View {
    
    @State private var isShowingModal: Bool = false
    @State private var isShowingMap: Bool = false
    @State private var tappedCountry: String = ""
    @State private var tappedContinent: String = ""
    @State private var tappedLocality: String = ""
    
    @Binding var pickerHour: Int
    @Binding var pickerFastOrSlow: [String]
    @Binding var selected: [Int]
    
    var body: some View {
        VStack(alignment: .leading) {
            if CountryList.list.GMT[gmtTargetResult(selected: selected)] != nil {
                WrappingHStack(CountryList.list.GMT[gmtTargetResult(selected: selected)]!, id: \.self) { tag in
                    Button {
                        HapticManager.instance.impact(style: .rigid)
                        if tag.isHaveLocality {
                            showLocality(isShowingModal: tag.isHaveLocality, countryName: tag.countryName, continent: tag.continent)
                        } else {
                            showLocality(isShowingModal: tag.isHaveLocality, countryName: tag.countryName, continent: tag.continent)
                            self.isShowingMap = true
                        }
                    } label: {
                        HStack {
                            Text(tag.countryName)
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.black)
                            if tag.isHaveLocality {
                                Circle()
                                    .foregroundColor(.clear)
                                    .overlay(
                                        Image(systemName: "ellipsis.circle.fill")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(.orange)
                                    )
                                    .padding(.leading, 4)
                            }
                        } // HStack
                        .padding(.horizontal, 18)
                        .padding(.vertical, 12)
                        .background(.white)
                        .cornerRadius(32)
                    } // Button
                    .padding(.bottom, 16)
                } // WrappingHStack
                .frame(width: screenWidth * 0.88)
            } else {
                Text("다시 시도해주세요.")
                    .font(.system(size: 17, weight: .black))
                    .foregroundColor(.white)
            }
        } // VStack닫기
        .sheet(isPresented: $isShowingModal) {
            NationDetailView(
                countryName: $tappedCountry,
                continent: $tappedContinent,
                pickerFastOrSlow: $pickerFastOrSlow,
                pickerHour: $pickerHour,
                selected: $selected
            )
        }
        .sheet(isPresented: $isShowingMap) {
            MapView(
                countryName: $tappedCountry,
                continent: $tappedContinent,
                locality: $tappedLocality
            )
        } //sheet닫기
    } // body닫기
    
    private func showLocality(isShowingModal: Bool, countryName: String, continent: String) {
        if isShowingModal {
            self.isShowingModal = true
            self.tappedCountry = countryName
            self.tappedContinent = continent
        } else {
            self.tappedCountry = countryName
            self.tappedContinent = continent
        }
    }
} // struct닫기
