//
//  CountryTagView.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/04.
//

import SwiftUI

struct CountryTagLayout: View {
    
    let geometry: GeometryProxy

    var body: some View {
        self.generateContent(in: geometry)
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(CountryList.list.UTC["UTC+9"]!, id: \.self) { tag in
                Button {
                    showLocality(isShowingModal: tag.isLocality)
                } label: {
                    ZStack {
                        HStack {
                            Text(tag.countryName)
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.black)
                                .padding(.trailing, 4)
                            if tag.isLocality {
                                Image(systemName: "ellipsis.circle.fill")
                                    .foregroundColor(.orange)
                                    .opacity(0)
                                    .overlay(
                                        Image(systemName: "ellipsis.circle.fill")
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(.orange)
                                    )
                            } // if닫기
                        } // HStack닫기
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(.white)
                        .cornerRadius(32)
                    } // ZStack닫기
                } // Button닫기
                .padding([.horizontal], 4)
                .padding([.vertical], 8)
                .alignmentGuide(.leading, computeValue: { d in
                    if (abs(width - d.width) > g.size.width)
                    {
                        width = 0
                        height -= d.height
                    }
                    let result = width
                    if tag == CountryList.list.UTC["UTC+9"]!.first! {
                        width = 0 //last item
                    } else {
                        width -= d.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: {d in
                    let result = height
                    if tag == CountryList.list.UTC["UTC+9"]!.first! {
                        height = 0 // last item
                    }
                    return result
                })
            } // ForEack닫기
        } // ZStack닫기
        .padding(.leading, UIScreen.main.bounds.width * 0.05)
    } // func닫기
} // struct닫기

struct CountryTagView_Previews: PreviewProvider {
    static var previews: some View {
        CountryTagLayout(geometry: GeometryReader(content: { SwiftUI.GeometryProxy in
            <#code#>
        }))
    }
}
