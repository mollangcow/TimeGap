//
//  NationView.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/17.
//

import SwiftUI
import WrappingHStack

struct NationView: View {
    
    @State private var isShowingModal: Bool = false
    @State private var isShowingMap: Bool = false
    @State private var tappedCountry: String = ""
    
    @Binding var pickerHour: Int
    @Binding var pickerFastOrSlow: [String]
    @Binding var selected: [Int]
    
    var body: some View {
        VStack(alignment: .leading) {
            if CountryList.list.GMT[gmtTargetResult()] != nil {
                WrappingHStack(CountryList.list.GMT[gmtTargetResult()]!, id: \.self) { tag in
                    Button {
                        HapticManager.instance.impact(style: .light)
                        if tag.isHaveLocality {
                            showLocality(isShowingModal: tag.isHaveLocality, countryName: tag.countryName)
                        } else {
                            showLocality(isShowingModal: tag.isHaveLocality, countryName: tag.countryName)
                            self.isShowingMap = true
                        }
                    } label: {
                        ZStack {
                            HStack {
                                Text(tag.countryName)
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(.trailing, 4)
                                if tag.isHaveLocality && tag.countryName == "대한민국" {
                                    Image(systemName: "circle")
                                        .foregroundColor(.clear)
                                        .overlay(
                                            Image(systemName: "ellipsis.circle.fill")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.blue)
                                        )
                                } else if tag.isHaveLocality {
                                    Image(systemName: "circle")
                                        .foregroundColor(.clear)
                                        .overlay(
                                            Image(systemName: "ellipsis.circle.fill")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.orange)
                                        )
                                }
                            } // HStack닫기
                            .padding(.horizontal, 18)
                            .padding(.vertical, 12)
                            .background(.white)
                            .cornerRadius(32)
                        } // ZStack닫기
                        .padding(.bottom, 16)
                    } // Button닫기
                } // WrappingHStack
                .frame(width: screenWidth * 0.88)
            } else {
                Text("다시 시도해주세요.")
                    .font(.system(size: 17, weight: .black))
                    .foregroundColor(.white)
            }
        } // VStack닫기
        .sheet(isPresented: $isShowingModal) {
            LocalityDetailView(
                countryName: $tappedCountry,
                pickerFastOrSlow: $pickerFastOrSlow,
                pickerHour: $pickerHour,
                selected: $selected
            )
            .presentationBackground(.regularMaterial)
        } //sheet닫기
        .sheet(isPresented: $isShowingMap) {
            MapView(
                countryName: $tappedCountry
            )
            .presentationBackground(.regularMaterial)
        } //sheet닫기
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
    
    private func showLocality(isShowingModal: Bool, countryName: String) {
        if isShowingModal {
            self.isShowingModal = true
            self.tappedCountry = countryName
        } else {
            self.tappedCountry = countryName
        }
    }
} // struct닫기
