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
            if CountryList.list.UTC[gmtTargetResult()] != nil {
                WrappingHStack(CountryList.list.UTC[gmtTargetResult()]!, id: \.self) { tag in
                    Button {
                        if tag.isHaveLocality {
                            showLocality(isShowingModal: tag.isHaveLocality, countryName: tag.countryName)
                        } else {
                            self.isShowingMap = true
                        }
                    } label: {
                        ZStack {
                            HStack {
                                Text(tag.countryName)
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(.black)
                                    .padding(.trailing, 4)
                                if tag.isHaveLocality {
                                    Image(systemName: "circle")
                                        .foregroundColor(.clear)
                                        .overlay(
                                            Image(systemName: "ellipsis.circle.fill")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.orange)
                                        )
                                }// if닫기
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
                Spacer()
                Text("다시 시도해주세요.")
                    .font(.system(size: 17, weight: .black))
                    .frame(width: screenWidth)
                    .foregroundColor(.white)
                    .padding(.bottom, screenHeight * 0.1)
            }
        } // VStack닫기
        .sheet(isPresented: $isShowingModal) {
            LocalityDetailView(
                countryName: $tappedCountry,
                pickerFastOrSlow: $pickerFastOrSlow,
                pickerHour: $pickerHour,
                selected: $selected
            )
            .presentationBackground(.thinMaterial)
        } //sheet닫기
        .sheet(isPresented: $isShowingMap) {
            MapView()
            .presentationBackground(.thinMaterial)
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
        }
    }
} // struct닫기
