//
//  NationView.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/17.
//

import SwiftUI

struct NationView: View {
    
    @State private var isShowingModal: Bool = false
    @State private var tappedCountry: String = ""
    
//    @Binding var targetTimeHour: String
//    @Binding var targetTimeMinute: String
//    @Binding var targetDate: String
    @Binding var pickerHour: Int
    @Binding var pickerFastOrSlow: [String]
    @Binding var selected: [Int]
    
    let geometry: GeometryProxy
//    let targetUtcTime: Int
    
//    let calcUTC: () -> Int
    
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
    
    var body: some View {
        VStack{
            if let countries = CountryList.list.UTC[gmtTargetResult()] {
                nationChips(in: geometry, countries: countries)
            } else {
                // targetUtcTime이 nil일 때 처리할 내용
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
//                targetTimeHour: $targetTimeHour,
//                targetTimeMinute : $targetTimeMinute,
//                targetDate: $targetDate,
                countryName: $tappedCountry,
                pickerHour: $pickerHour,
                pickerFastOrSlow: $pickerFastOrSlow,
                selected: $selected
//                targetUtcTime: targetUtcTime
            )
        } //sheet닫기
    } // body닫기
    private func showLocality(isShowingModal: Bool, countryName: String) {
        if isShowingModal {
            self.isShowingModal = true
            self.tappedCountry = countryName
        }
    }
    private func nationChips(in g: GeometryProxy, countries: [Country]) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(CountryList.list.UTC[gmtTargetResult()]!, id: \.self) { tag in
                Button {
                    showLocality(isShowingModal: tag.isHaveLocality, countryName: tag.countryName)
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
                            } // if닫기
                        } // HStack닫기
                        .padding(.horizontal, 18)
                        .padding(.vertical, 12)
                        .background(.white)
                        .cornerRadius(32)
                    } // ZStack닫기
                } // Button닫기
                .padding(.trailing, 8)
                .padding(.bottom, 16)
                .alignmentGuide(.leading, computeValue: { d in
                    if (abs(width - d.width - 8) > g.size.width)
                    {
                        width = 0
                        height -= d.height
                    }
                    let result = width
                    if tag == CountryList.list.UTC[gmtTargetResult()]!.first! {
                        width = 0 //last item
                    } else {
                        width -= d.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: {d in
                    let result = height
                    if tag == CountryList.list.UTC[gmtTargetResult()]!.first! {
                        height = 0 // last item
                    }
                    return result
                })
            } // ForEach닫기
        } // ZStack닫기
        .padding(.leading, 20)
    } // func닫기
} // struct닫기
