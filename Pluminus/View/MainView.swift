//
//  MainView.swift
//  NC1
//  Created by kimsangwoo on 2023/06/01.
//
//

import CoreLocation
import SwiftUI
import WrappingHStack

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
    
    @StateObject var locationManager = MyLocationManager()
    
    @State private var dataSource: [[String]] = [["+","-"], []]
    @State private var pickerFastOrSlow: [String] = ["ahead", "+"]
    @State private var rectangleHeight: CGFloat = 1
    @State private var pickerHour: Int = 0
    
    @State private var spacerWidth: CGFloat = 0
    
    @Namespace private var animation
    
    @State private var expandedCountry: Country? = nil
    @State private var offset: CGFloat = .zero
    @State private var hiddenCountryIndices: Set<Int> = []
    
    private let threshold: CGFloat = 100
    
    @State private var isShowingMap: Bool = false
    @State private var tappedCountry: String = ""
    @State private var tappedContinent: String = ""
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(currentTimeAString)
                            .font(.system(size: 64, weight: isShowingResult ? .thin : .heavy))
                            .foregroundStyle(isShowingResult ? .white : .primary)
                            .contentTransition(.numericText())
                        
                        Text(currentTimeHMMSSString)
                            .font(.system(size: 64, weight: isShowingResult ? .thin : .heavy))
                            .foregroundStyle(isShowingResult ? .white : .primary)
                            .contentTransition(.numericText())
                        
                        Text(currentDateStirng)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundStyle(isShowingResult ? .white : .primary)
                            .contentTransition(.numericText())
                    } // VStack
                    
                    Spacer()
                    
                    // 설정 버튼
                    if isShowingResult == false {
                        Button {
                            HapticManager.instance.impact(style: .light)
                            isShowingSettingView = true
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundStyle(.gray.opacity(0.4))
                                .padding(.top, 12)
                        }
                    }
                } //HStack
                .padding(.top, 12)
                
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
                .padding(.top, 8)
                
                if isShowingResult == false {
                    Spacer()
                    
                    HStack {
                        CustomPicker(dataSource: $dataSource, selectedPicker: $selectedPicker)
                            .frame(width:160)
                            .id(dataSource)
                            .onChange(of: selectedPicker[0]) { oldValue, newValue in
                                print(">>>>> Picker OnChange [0] : \(selectedPicker[0])")
                                withAnimation {
                                    pickerFastOrSlow = newValue == 0 ? ["ahead", "+"] : ["behind", "-"]
                                    _ = hourRange
                                    dataSource[1] = Array(hourRange).map { String($0) }
                                    selectedPicker[1] = 0
                                    _ = calcTargetLocalGMT(selectedPicker: selectedPicker)
                                }
                            }
                            .onChange(of: selectedPicker[1]) { oldValue, newValue in
                                HapticManager.instance.impact(style: .medium)
                                print(">>>>> Picker OnChange [1] : \(selectedPicker[1])")
                                withAnimation {
                                    pickerHour = newValue
                                    _ = hourRange
                                    dataSource[1] = Array(hourRange).map { String($0) }
                                    _ = calcTargetLocalGMT(selectedPicker: selectedPicker)
                                }
                            }
                            .onChange(of: dataSource) { oldValue, newValue in
                                HapticManager.instance.impact(style: .medium)
                                print("<<<<< Picker OnChange(dataSource)")
                                withAnimation {
                                    _ = hourRange
                                    dataSource[1] = Array(hourRange).map { String($0) }
                                }
                            }
                            .onAppear(perform: {
                                print("^^^^^ Picker OnAppear")
                                _ = calcTargetLocalGMT(selectedPicker: selectedPicker)
                                _ = hourRange
                                dataSource[1] = Array(hourRange).map { String($0) }
                            })
                            .onDisappear {
                                print("^^^^^ Picker OnDisappear")
                                _ = calcTargetLocalGMT(selectedPicker: selectedPicker)
                                _ = hourRange
                                dataSource[1] = Array(hourRange).map { String($0) }
                            }
                        
                        Text("Hour")
                            .font(.system(size: 17, weight: .bold))
                    }
                    
                    Spacer()
                    
                    // GMT 시간대 시각화 그래프
                    ZStack {
                        HStack {
                            Text("GMT-12")
                                .font(.system(size: 7, weight: .regular))
                            
                            Rectangle()
                                .frame(width: 260, height: 1)
                                .foregroundColor(.gray.opacity(0.3))
                            
                            Text("GMT+14")
                                .font(.system(size: 7, weight: .regular))
                        } //HStack
                        
                        
                        // base location pin
                        HStack {
                            Spacer()
                                .frame(width: pickerVisualStaticSpacer())
                            
                            RoundedRectangle(cornerRadius: 1)
                                .frame(width: 2, height: 10)
                                .foregroundColor(.primary.opacity(0.3))
                            
                            Spacer()
                        } //HStack
                        .frame(width: 260)
                        
                        // target location pin
                        HStack {
                            Spacer()
                                .frame(width: spacerWidth)
                                .onAppear {
                                    withAnimation {
                                        self.spacerWidth = pickerVisualMovingSpacer()
                                    }
                                }
                                .onChange(of: selectedPicker) { oldValue, newValue in
                                    if oldValue != newValue {
                                        withAnimation {
                                            self.spacerWidth = pickerVisualMovingSpacer()
                                        }
                                    }
                                }
                            
                            RoundedRectangle(cornerRadius: 1)
                                .frame(width: 2, height: 10)
                                .foregroundColor(.primary)
                            
                            Spacer()
                        } //HStack
                        .frame(width: 260)
                    } //ZStack
                    
                    if pickerHour == 0  {
                        Text("Same time zone as base")
                            .font(.system(size: 14, weight: .regular))
                            .padding(.top, 10)
                            .padding(.bottom, 40)
                            .contentTransition(.numericText())
                    } else {
                        Text("\(pickerHour)hours \(pickerFastOrSlow[0]) of base")
                            .font(.system(size: 14, weight: .regular))
                            .padding(.top, 10)
                            .padding(.bottom, 40)
                            .contentTransition(.numericText())
                    }
                } else {
                    // Time gap visual graph
                    HStack {
                        VStack {
                            HStack(alignment: .bottom) {
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
                                    .padding(.leading, 20)
                                    .onAppear {
                                        withAnimation(.spring(duration: 1.0)) {
                                            rectangleHeight = calcTimeGapStrokeHeight(pickerHour: pickerHour)
                                        }
                                    }
                                    .onDisappear {
                                        rectangleHeight = 1
                                    }
                                
                                Text("\(pickerFastOrSlow[1]) \(pickerHour)Hour")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                    .frame(height: screenHeight * 0.18)
                    
                    // Target Time
                    HStack(alignment: .bottom) {
                        Text(Date().currentLocalTime(tzOffset: selectPickerResult(selectedPicker: selectedPicker)))
                            .font(.system(size: 64, weight: .heavy))
                            .foregroundColor(.white)
                        
                        Text("GMT\(showingTargetLocalGMT(selectedPicker: selectedPicker))")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.bottom, 16)
                        
                        Spacer()
                    }
                    
                    // Target Date
                    HStack {
                        Text(Date().currentLocalDate(tzOffset: selectPickerResult(selectedPicker: selectedPicker)))
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.leading, 4)
                        
                        Spacer()
                    }
                    .padding(.bottom, 4)
                    
                    ScrollView {
                        let countries = CountryList.list.GMT[calcTargetLocalGMT(selectedPicker: selectedPicker)]
                        
                        if countries != nil {
                            WrappingHStack(countries!, id: \.self) { country in
                                Button {
                                    HapticManager.instance.impact(style: .rigid)
                                    
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.95, blendDuration: 0.9)) {
                                        if expandedCountry?.countryName == country.countryName {
                                            expandedCountry = nil
                                        } else {
                                            expandedCountry = country
                                            tappedCountry = country.countryName
                                            tappedContinent = country.continent
                                        }
                                    }
                                } label: {
                                    HStack {
                                        Text(country.countryName)
                                            .font(.system(size: 17, weight: .bold))
                                            .padding(.horizontal, 6)
                                            .frame(height: 24)
                                            .minimumScaleFactor(0.7)
                                            .foregroundStyle(Color.black)
                                        if country.isHaveLocality {
                                            Image(systemName: "ellipsis.circle.fill")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                                .foregroundColor(.orange)
                                        }
                                    } // HStack
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 10)
                                    .background(.white)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 32)
                                    )
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 32)
                                            .strokeBorder(lineWidth: 1)
                                            .foregroundStyle(Color.secondary.opacity(0.1))
                                    }
                                    .opacity(hiddenCountryIndices.contains(country.hashValue) ? 0 : 1)
                                    .matchedGeometryEffect(id: country.hashValue, in: animation)
                                } // Button
                                .padding(.vertical, 4)
                            } // WrappingHStack
                            .padding(.vertical, 12)
                        } else {
                            Text("Indexing Error!")
                                .font(.system(size: 17, weight: .black))
                                .foregroundColor(.white)
                        }
                    }
                    .scrollIndicators(.hidden)
                    .mask(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: .clear, location: 0.0),
                                .init(color: .black, location: 0.05),
                                .init(color: .black, location: 0.95),
                                .init(color: .clear, location: 1.0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                }
                
                // 확인/돌아오기 버튼
                Button {
                    HapticManager.instance.notification(type: .warning)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.spring) {
                            isShowingResult.toggle()
                            isShowingSearchingLabel.toggle()
                        }
                    }
                } label: {
                    Image(systemName: "arrow.forward")
                        .rotationEffect(.degrees(isShowingSearchingLabel ? 0 : 180)) // 회전 효과 추가
                        .foregroundStyle(.white)
                        .font(.system(size: 24, weight: .black))
                        .frame(maxWidth: 500, maxHeight: 70)
                        .background(isShowingResult ? Color.black : Color.orange)
                        .clipShape(RoundedRectangle(cornerRadius: 100))
                } // Button
                .padding(.horizontal, isShowingResult ? 0 : 72)
                .padding(.top, 8)
                .padding(.bottom, 20)
            } // VStack
            .padding(.horizontal, 20)
            .sheet(isPresented: $isShowingSettingView) {
                SettingView()
                    .presentationDetents([.large])
                    .presentationCornerRadius(32)
            }
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
            
            if let expandedCountry = expandedCountry {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                
                VStack {
                    NationDetailView(
                        countryName: $tappedCountry,
                        continent: $tappedContinent,
                        pickerFastOrSlow: $pickerFastOrSlow,
                        pickerHour: $pickerHour,
                        selectedPicker: $selectedPicker
                    )
                    .frame(maxWidth: .infinity)
                    .background(.thickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 32))
                    .matchedGeometryEffect(id: expandedCountry.hashValue, in: animation)
                    .padding(.top, 20)
                    .offset(y: offset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let yOffset = value.translation.height
                                if yOffset > 0 {
                                    offset = yOffset
                                }
                            }
                            .onEnded { value in
                                if offset > threshold {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.85, blendDuration: 0.1)) {
                                        self.expandedCountry = nil
                                        offset = .zero
                                        hiddenCountryIndices.remove(expandedCountry.hashValue)
                                    }
                                } else {
                                    withAnimation {
                                        offset = .zero
                                    }
                                }
                            }
                    )
                }
                .zIndex(1)
                .edgesIgnoringSafeArea(.bottom)
            }
            
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
    
    private func pickerVisualMovingSpacer() -> CGFloat {
        let hour = calcTargetLocalGMT(selectedPicker: selectedPicker)
        
        if hour == -12 {
            return 0
        } else if hour == 0 {
            return 130
        } else if hour >= -11 && hour <= 14 {
            return CGFloat(hour + 12) * 10
        }
        
        return 0
    }
    
    private func pickerVisualStaticSpacer() -> CGFloat {
        let hour = calcCurrentLocalGMT()
        
        if hour == -12 {
            return 0
        } else if hour == 0 {
            return 130
        } else if hour >= -11 && hour <= 14 {
            return CGFloat(hour + 12) * 10
        }
        
        return 0
    }
    
    private func calcTimeGapStrokeHeight(pickerHour: Int) -> CGFloat {
        let minHeight: CGFloat = screenHeight * 0.02
        let maxHeight: CGFloat = screenHeight * 0.2
        let hourRange: ClosedRange<Int> = 0...27
        
        let normalizedHour = CGFloat(pickerHour - hourRange.lowerBound) / CGFloat(hourRange.upperBound - hourRange.lowerBound)
        
        let calculatedHeight = minHeight + (maxHeight - minHeight) * normalizedHour
        
        return calculatedHeight
    }
    
    private var hourRange: ClosedRange<Int> {
        var wrappedGMT = calcCurrentLocalGMT() <= -11 ? -10 : calcCurrentLocalGMT()
        wrappedGMT = calcCurrentLocalGMT() >= 14 ? 13 : calcCurrentLocalGMT()
        
        if selectedPicker[0] == 0 {
            let min = 0
            let max = 14 - wrappedGMT
            
            return min...max
            
        } else {
            let min = 0
            let max = abs(-12 - wrappedGMT)
            
            return min...max
        }
    }
} // struct
