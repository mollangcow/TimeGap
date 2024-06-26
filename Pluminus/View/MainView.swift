//
//  MainView.swift
//  NC1
//  Created by kimsangwoo on 2023/06/01.
//
//

import CoreLocation
import SwiftUI

struct MainView: View {    
    @State var isLaunching: Bool = true
    
    @State private var currentLocalName: String = ""
    @State private var selectedPicker: [Int] = [0, 0]
    @State private var isShowingResult: Bool = false
    @State private var isShowingSearchingLabel: Bool = true
    @State private var isShowingSettingView: Bool = false
    @State private var isShowingLocalSelectView: Bool = false
    
    @State private var isShowingCLMapView: Bool = false
    @State private var savedLocation: CLLocationCoordinate2D?
    @State private var cLName = "Unknown"
    @State private var tzOffset = 0
    
    @State private var currentTimeAString: String = ""
    @State private var currentTimeHMMSSString: String = ""
    @State private var currentDateStirng: String = ""
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    func cTimeA(tzOffset: Int) -> String {
        let fmt = DateFormatter()
        let offsetInSeconds = tzOffset * 3600
        let targetTimeZone = TimeZone(secondsFromGMT: offsetInSeconds)
        
        fmt.timeZone = targetTimeZone
        fmt.dateFormat = "a"
        fmt.locale = Locale(identifier: "en_US")
        
        return fmt.string(from: Date())
    }
    
    func cTimeHMMSS(tzOffset: Int) -> String {
        let fmt = DateFormatter()
        let offsetInSeconds = tzOffset * 3600
        let targetTimeZone = TimeZone(secondsFromGMT: offsetInSeconds)
        
        fmt.timeZone = targetTimeZone
        fmt.dateFormat = "h:mm:ss"
        fmt.locale = Locale(identifier: "en_US")
        
        return fmt.string(from: Date())
    }

    func cDate(tzOffset: Int) -> String {
        let fmt = DateFormatter()
        let offsetInSeconds = tzOffset * 3600
        let targetTimeZone = TimeZone(secondsFromGMT: offsetInSeconds)
        
        fmt.timeZone = targetTimeZone
        fmt.dateFormat = "E dd, MMM yyyy"
        fmt.locale = Locale(identifier: "en_US")
        
        return fmt.string(from: Date())
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(currentTimeAString)
                            .font(.system(size: 64, weight: isShowingResult ? .thin : .heavy))
                            .foregroundColor(isShowingResult ? .white : .primary)
                            .contentTransition(.numericText())
                        
                        Text(currentTimeHMMSSString)
                            .font(.system(size: 64, weight: isShowingResult ? .thin : .heavy))
                            .foregroundColor(isShowingResult ? .white : .primary)
                            .contentTransition(.numericText())
                        
                        Text(currentDateStirng)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(isShowingResult ? .white : .primary)
                            .contentTransition(.numericText())
                    } // VStack
                    
                    
                    Spacer()
                    
                    // 설정 버튼
                    if isShowingResult == false {
                        Button {
                            HapticManager.instance.impact(style: .light)
                            isShowingSettingView = true
                        } label: {
                            Rectangle()
                                .frame(width: 24, height: 44)
                                .foregroundStyle(.clear)
                                .overlay() {
                                    Image(systemName: "gearshape.fill")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundStyle(.gray.opacity(0.4))
                                }
                        }
                    }
                } //HStack
                .padding(.top, 20)
                
                // 기준 시간을 설정하는 위치
                HStack {
                    Spacer()
                    
                    Button {
                        HapticManager.instance.impact(style: .rigid)
                        isShowingCLMapView = true
                    } label: {
                        Image(isShowingResult ? "locationPin.white" : "locationPin.orange")
                                .resizable()
                                .frame(width: 15, height: 19)
                            Text(currentLocalName)
                                .font(.system(size: 20, weight: .heavy))
                                .foregroundColor(isShowingResult ? .white : .primary)
                        
                    }
                    .disabled(isShowingResult == true)
                } // HStack
                
                Spacer()
                
                // 시차 선택 커스텀 피커뷰
                NationAndPickerView(
                    selectedPicker: $selectedPicker,
                    isShowingResult: $isShowingResult
                )
                
                // 확인/돌아오기 버튼
                Button {
                    HapticManager.instance.notification(type: .warning)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.spring) {
                            isShowingResult.toggle()
                        }
                        isShowingSearchingLabel.toggle()
                    }
                } label: {
                    Text(isShowingSearchingLabel ? "Check" : "Back")
                        .foregroundStyle(.white)
                        .font(.system(size: 17, weight: .black))
                        .frame(maxWidth : 500, maxHeight: 70)
                        .background(isShowingResult ? Color.black.opacity(0.2) : Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 100))
                } // Button
                .padding(.horizontal, isShowingResult ? 0 : 72)
                .padding(.bottom, 30)
            } // VStack
            .padding(.horizontal, 20)
            .sheet(isPresented: $isShowingSettingView) {
                SettingView()
                    .presentationDetents([.large])
                    .presentationCornerRadius(32)
            }
            //        .sheet(isPresented: $isShowingLocalSelectView) {
            //            LocaleSelectView(isShowingLocalSelectView: $isShowingLocalSelectView, selectedLocationName: $currentLocalName)
            //        }
            .sheet(isPresented: $isShowingCLMapView, content: {
                CLMapView(isShowingCLMapView: $isShowingCLMapView, savedLocation: $savedLocation) { locationName in
                    cLName = locationName
                    isShowingCLMapView = false // Dismiss sheet after saving
                }
                .presentationDetents([.large])
                .presentationCornerRadius(32)
            })
            .background(
                BackColorView(
                    isShowingResult: $isShowingResult,
                    selectedPicker: $selectedPicker
                )
            )
            .statusBarHidden()
            
            if isLaunching {
                SplashView()
            }
        } // ZStack
        .onReceive(locationManager.$currentLocalName) { newLocation in
            self.currentLocalName = newLocation
        }
        .onReceive(timer) { _ in
            withAnimation {
                currentTimeAString = cTimeA(tzOffset: calcCurrentLocalGMT())
                currentTimeHMMSSString = cTimeHMMSS(tzOffset: calcCurrentLocalGMT())
                currentDateStirng = cDate(tzOffset: calcCurrentLocalGMT())
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    isLaunching = false
                }
            }
        }
    } // body
} // struct
