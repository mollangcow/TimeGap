//
//  BackColorView.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/07.
//

import SwiftUI

struct BackColorView: View {
    
    @Binding var isShowingMainCenterStackView: Bool
    @Binding var targetTimeHour: String

    init(isShowingMainCenterStackView: Binding<Bool>, targetTimeHour: Binding<String>) {
        self._isShowingMainCenterStackView = isShowingMainCenterStackView
        self._targetTimeHour = targetTimeHour
    }
    
    var body: some View {
        ZStack {
            if isShowingMainCenterStackView {
                EmptyView()
            } else {
                getBackgroundColor()
                .ignoresSafeArea()
            }
        }
        .onChange(of: targetTimeHour) { newValue in
            targetTimeHour = newValue
        }
    } // body닫기
    
    func getBackgroundColor() -> LinearGradient {
        if targetTimeHour == "05" || targetTimeHour == "06"  {
            return LinearGradient(gradient: Gradient(colors: [Color.G0506_Top, Color.G0506_Center, Color.G0506_Bottom]),
                               startPoint: .center, endPoint: .bottom)
        }
        else if targetTimeHour == "07" || targetTimeHour == "08" {
            return LinearGradient(gradient: Gradient(colors: [Color.G0708_Top, Color.G0708_Center, Color.G0708_Bottom]),
                           startPoint: .center, endPoint: .bottom)
        }
        else if targetTimeHour == "09" || targetTimeHour == "10" {
            return LinearGradient(gradient: Gradient(colors: [Color.G0910_Top, Color.G0910_Center, Color.G0910_Bottom]),
                           startPoint: .center, endPoint: .bottom)
        }
        else if targetTimeHour == "11" || targetTimeHour == "12" {
            return LinearGradient(gradient: Gradient(colors: [Color.G1112_Top, Color.G1112_Center, Color.G1112_Bottom]),
                           startPoint: .center, endPoint: .bottom)
        }
        else if targetTimeHour == "13" || targetTimeHour == "14" {
            return LinearGradient(gradient: Gradient(colors: [Color.G1314_Top, Color.G1314_Center, Color.G1314_Bottom]),
                           startPoint: .center, endPoint: .bottom)
        }
        else if targetTimeHour == "15" || targetTimeHour == "16" {
            return LinearGradient(gradient: Gradient(colors: [Color.G1516_Top, Color.G1516_Center, Color.G1516_Bottom]),
                           startPoint: .center, endPoint: .bottom)
        }
        else if targetTimeHour == "17" || targetTimeHour == "18" {
            return LinearGradient(gradient: Gradient(colors: [Color.G1718_Top, Color.G1718_Center, Color.G1718_Bottom]),
                           startPoint: .center, endPoint: .bottom)
        }
        else if targetTimeHour == "19" || targetTimeHour == "20" {
            return LinearGradient(gradient: Gradient(colors: [Color.G1920_Top, Color.G1920_Center, Color.G1920_Bottom]),
                           startPoint: .center, endPoint: .bottom)
        }
        else if targetTimeHour == "21" || targetTimeHour == "22" {
            return LinearGradient(gradient: Gradient(colors: [Color.G2122_Top, Color.G2122_Center, Color.G2122_Bottom]),
                           startPoint: .center, endPoint: .bottom)
        }
        else if targetTimeHour == "23" || targetTimeHour == "00" {
            return LinearGradient(gradient: Gradient(colors: [Color.G2300_Top, Color.G2300_Center, Color.G2300_Bottom]),
                           startPoint: .center, endPoint: .bottom)
        }
        else if targetTimeHour == "01" || targetTimeHour == "02" {
            return LinearGradient(gradient: Gradient(colors: [Color.G0102_Top, Color.G0102_Center, Color.G0102_Bottom]),
                           startPoint: .center, endPoint: .bottom)
        }
        else if targetTimeHour == "03" || targetTimeHour == "04" {
            return LinearGradient(gradient: Gradient(colors: [Color.G0304_Top, Color.G0304_Center, Color.G0304_Bottom]),
                           startPoint: .center, endPoint: .bottom)
        }
        else {
            return LinearGradient(gradient: Gradient(colors: [Color.primary, Color.primary, Color.primary]),
                           startPoint: .center, endPoint: .bottom)
        }
    } // func닫기
} // struct닫기

struct BackColorView_Previews: PreviewProvider {
    static var previews: some View {
        BackColorView(
            isShowingMainCenterStackView: .constant(true),
            targetTimeHour: .constant("--")
        )
    }
}
