//
//  LocaleSelectCityView.swift
//  Pluminus
//
//  Created by kimsangwoo on 4/2/24.
//

import SwiftUI

struct LocaleSelectCityView: View {
    @State private var searchText = ""
    @State private var cityName: String = ""
    @State private var selectedLocalTime: String = ""
    
    @Binding var isShowingLocal : Bool
    @Binding var selectedLocationName : String
    
    var cities: [String]
    var countryName: String // 도시 목록이 비어있을 때 국가 이름을 표시하기 위한 프로퍼티
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            if cities.isEmpty {
                // 도시 목록이 비어있을 때 처리할 내용
                VStack {
                    Button(action: {
                        HapticManager.instance.impact(style: .rigid)
                        isShowingLocal = false
                        
                        selectedLocationName = countryName
                        
                        print("City Select : \(countryName)")
                    }) {
                        HStack {
                            Text(countryName)
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(Color.primary)
                                .padding(.leading, 20)
                            
                            Spacer()
                        }
                        .frame(height: 60, alignment: .leading)
                        .background(.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal, 16)
                    }
                    
                    Text("\(countryName)에는 선택 가능한 도시 목록이 없습니다.")
                        .padding(.top, 12)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } //VStack
            } else {
                // 도시 목록이 비어있지 않을 때 도시를 출력
                LazyVStack {
                    ForEach(filteredCities, id: \.self) { city in
                        Button(action: {
                            HapticManager.instance.impact(style: .rigid)
                            isShowingLocal = false
                            
                            selectedLocationName = city
                            cityName = city
                            
                            getLocalTime(cityName: cityName) { time in
                                self.selectedLocalTime = time
                                print("ssssss : \(selectedLocalTime)")
                            }
                            
                            print("City Select : \(city)")
                        }) {
                            HStack {
                                Text(city)
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(Color.primary)
                                    .padding(.leading, 20)
                                
                                Spacer()
                            }
                            .frame(height: 60, alignment: .leading)
                            .background(.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding(.horizontal, 16)
                        }
                    } //ForEach
                } //LazyVStack
            } //ifelse
        } //ScrollView
        .navigationTitle("\(countryName)의 도시")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText)
    } //body
    
    var filteredCities: [String] {
        if searchText.isEmpty {
            return cities
        } else {
            return cities.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
} //sturct
