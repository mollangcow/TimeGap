//
//  MainView.swift
//  NC1
//  Created by kimsangwoo on 2023/06/01.
//
//

import SwiftUI

struct MainView: View {
    @State private var currentLocationName : String = ""
    @State private var selectedPicker : [Int] = [0, 0]
    @State private var isShowingResualt : Bool = true
    @State private var isButtonLabelDefult : Bool = true
    @State private var isShowingSetting : Bool = false
    @State private var isShowingLocal : Bool = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0) {
                    // 기준 시간
                    Text(Date().currentTime(timeZoneOffset: 0))
                        .font(.system(size: 64, weight: isShowingResualt ? .heavy : .thin))
                        .foregroundColor(isShowingResualt ? .primary : .white)
                    // 기준 날짜
                    Text(Date().currentDate(timeZoneOffset: 0))
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(isShowingResualt ? .primary : .white)
                } //VStack
                
                Spacer()
                
                // 설정 버튼
                if isShowingResualt {
                    Button(action: {
                        HapticManager.instance.impact(style: .light)
                        isShowingSetting = true
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
                
                Image(isShowingResualt ? "locationPin.orange" : "locationPin.white")
                    .resizable()
                    .frame(width: 15, height: 19)
                
                Button(action: {
                    HapticManager.instance.impact(style: .rigid)
                    isShowingLocal = true
                }, label: {
                    Text(currentLocationName)
                        .font(.system(size: 20, weight: .heavy))
                        .foregroundColor(isShowingResualt ? .primary : .white)
                })
                .disabled(isShowingResualt == false)
            } // HStack
            
            Spacer()
            
            // 시차 선택 커스텀 피커뷰
            NationAndPickerView(
                selectedPicker: $selectedPicker, isShowingResualt: $isShowingResualt
            )
            
            // 확인/돌아오기 버튼
            Button(action: {
                HapticManager.instance.notification(type: .warning)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.spring) {
                        isShowingResualt.toggle()
                    }
                    isButtonLabelDefult.toggle()
                }
            }, label: {
                Text(isButtonLabelDefult ? "확인하기" : "돌아가기")
                    .foregroundStyle(.white)
                    .font(.system(size: 17, weight: .black))
                    .frame(width: isShowingResualt ? screenWidth * 0.6 : screenWidth * 0.88, height: 70)
                    .background(isShowingResualt ? Color.orange : Color.black.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 100))
            }) // Button
            .padding(.bottom, 30)
        } // VStack
        .padding(.horizontal, 20)
        .sheet(isPresented: $isShowingSetting) {
            SettingView()
        }
        .sheet(isPresented: $isShowingLocal) {
            LocaleSelectView(isShowingLocal: $isShowingLocal, selectedLocationName: $currentLocationName)
        }
        .onReceive(locationManager.$currentLocationName) { newLocation in
            self.currentLocationName = newLocation
        }
        .background(BackColorView(isShowingResualt: $isShowingResualt, selectedPicker: $selectedPicker))
        .statusBarHidden()
    } // body
} // struct
