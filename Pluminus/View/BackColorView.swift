//
//  BackColorView.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/07.
//

import SwiftUI

enum TimeGradient {
    case G0001, G0203, G0405, G0607, G0809, G1011, G1213, G1415, G1617, G1819, G2021, G2223, GNone
    
    @ViewBuilder var gradient: some View {
        switch self {
        case .G0001:
            Gradient0001()
        case .G0203:
            Gradient0203()
        case .G0405:
            Gradient0405()
        case .G0607:
            Gradient0607()
        case .G0809:
            Gradient0809()
        case .G1011:
            Gradient1011()
        case .G1213:
            Gradient1213()
        case .G1415:
            Gradient1415()
        case .G1617:
            Gradient1617()
        case .G1819:
            Gradient1819()
        case .G2021:
            Gradient2021()
        case .G2223:
            Gradient2223()
        case .GNone:
            GradientNone()
        }
    }
}

struct BackColorView: View {
    @Binding var isShowingResualt: Bool
    @Binding var selectedPicker: [Int]
    
    var body: some View {
        ZStack {
            if !isShowingResualt {
                getBackgroundColor(targetHourResult: targetHourResult(selectedPicker: selectedPicker))
                    .edgesIgnoringSafeArea(.all)
            }
        }
    } // body닫기
} // struct닫기

func getBackgroundColor(targetHourResult: Int) -> some View {
    switch targetHourResult {
    case 0...1:
        return TimeGradient.G0001.gradient
    case 2...3:
        return TimeGradient.G0203.gradient
    case 4...5:
        return TimeGradient.G0405.gradient
    case 6...7:
        return TimeGradient.G0607.gradient
    case 8...9:
        return TimeGradient.G0809.gradient
    case 10...11:
        return TimeGradient.G1011.gradient
    case 12...13:
        return TimeGradient.G1213.gradient
    case 14...15:
        return TimeGradient.G1415.gradient
    case 16...17:
        return TimeGradient.G1617.gradient
    case 18...19:
        return TimeGradient.G1819.gradient
    case 20...21:
        return TimeGradient.G2021.gradient
    case 22...23:
        return TimeGradient.G2223.gradient
    default:
        return TimeGradient.GNone.gradient
    }
}

