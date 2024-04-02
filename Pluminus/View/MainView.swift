//
//  MainView.swift
//  NC1
//  Created by kimsangwoo on 2023/06/01.
//
//

import SwiftUI

struct MainView: View {
    @State private var currentLocalName : String = ""
    @State private var selectedPicker : [Int] = [0, 0]
    @State private var isShowingResult : Bool = true
    @State private var isShowingSearchingLabel : Bool = true
    @State private var isShowingSettingView : Bool = false
    @State private var isShowingLocalSelectView : Bool = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0) {
                    // 기준 시간
                    Text(Date().currentLocalTime(timeZoneOffset: 0))
                        .font(.system(size: 64, weight: isShowingResult ? .heavy : .thin))
                        .foregroundColor(isShowingResult ? .primary : .white)
                    // 기준 날짜
                    Text(Date().currentLocalDate(timeZoneOffset: 0))
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(isShowingResult ? .primary : .white)
                } //VStack
                
                Spacer()
                
                // 설정 버튼
                if isShowingResult {
                    Button(action: {
                        HapticManager.instance.impact(style: .light)
                        isShowingSettingView = true
                    }, label: {
                        Rectangle()
                            .frame(width: 24, height: 44)
                            .foregroundStyle(.clear)
                            .overlay() {
                                Image(systemName: "gearshape.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundStyle(.gray.opacity(0.4))
                            }
                    })
                }
            } //HStack
            .padding(.top, 20)
            
            // 기준 시간을 설정하는 위치
            HStack {
                Spacer()
                
                Image(isShowingResult ? "locationPin.orange" : "locationPin.white")
                    .resizable()
                    .frame(width: 15, height: 19)
                
                Button(action: {
                    HapticManager.instance.impact(style: .rigid)
                    isShowingLocalSelectView = true
                }, label: {
                    Text(currentLocalName)
                        .font(.system(size: 20, weight: .heavy))
                        .foregroundColor(isShowingResult ? .primary : .white)
                })
                .disabled(isShowingResult == false)
            } // HStack
            
            Spacer()
            
            // 시차 선택 커스텀 피커뷰
            NationAndPickerView(
                selectedPicker: $selectedPicker, isShowingResult: $isShowingResult
            )
            
            // 확인/돌아오기 버튼
            Button(action: {
                HapticManager.instance.notification(type: .warning)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.spring) {
                        isShowingResult.toggle()
                    }
                    isShowingSearchingLabel.toggle()
                }
            }, label: {
                Text(isShowingSearchingLabel ? "확인하기" : "돌아가기")
                    .foregroundStyle(.white)
                    .font(.system(size: 17, weight: .black))
                    .frame(width: isShowingResult ? screenWidth * 0.6 : screenWidth * 0.88, height: 70)
                    .background(isShowingResult ? Color.orange : Color.black.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 100))
            }) // Button
            .padding(.bottom, 30)
        } // VStack
        .padding(.horizontal, 20)
        .sheet(isPresented: $isShowingSettingView) {
            SettingView()
        }
        .sheet(isPresented: $isShowingLocalSelectView) {
            LocaleSelectView(isShowingLocalSelectView: $isShowingLocalSelectView, selectedLocationName: $currentLocalName)
        }
        .onReceive(locationManager.$currentLocalName) { newLocation in
            self.currentLocalName = newLocation
        }
        .background(BackColorView(isShowingResult: $isShowingResult, selectedPicker: $selectedPicker))
        .statusBarHidden()
    } // body
} // struct
