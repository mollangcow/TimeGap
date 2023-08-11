//
//  ColorHex.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/01.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double((rgb >> 0) & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}

extension Color {
    
    // 05시 ~ 06시 배경 색상
    static let G0506_Top = Color(hex: "3453A5")
    static let G0506_Center = Color(hex: "AC5BB6")
    static let G0506_Bottom = Color(hex: "F05D5D")
    
    // 07시 ~ 08시 배경 색상
    static let G0708_Top = Color(hex: "5785DC")
    static let G0708_Center = Color(hex: "DF9FE6")
    static let G0708_Bottom = Color(hex: "FFC260")
    
    // 09시 ~ 10시 배경 색상
    static let G0910_Top = Color(hex: "80BCFF")
    static let G0910_Center = Color(hex: "E5D2FF")
    static let G0910_Bottom = Color(hex: "DDE0FF")
    
    // 11시 ~ 12시 배경 색상
    static let G1112_Top = Color(hex: "8FCEFF")
    static let G1112_Center = Color(hex: "D2E5FF")
    static let G1112_Bottom = Color(hex: "C5E4FF")
    
    // 13시 ~ 14시 배경 색상
    static let G1314_Top = Color(hex: "67C1FF")
    static let G1314_Center = Color(hex: "CDF1FF")
    static let G1314_Bottom = Color(hex: "F0FBFF")
    
    // 15시 ~ 16시 배경 색상
    static let G1516_Top = Color(hex: "579FFF")
    static let G1516_Center = Color(hex: "B3EAFF")
    static let G1516_Bottom = Color(hex: "E7F2FF")
    
    // 17시 ~ 18시 배경 색상
    static let G1718_Top = Color(hex: "5A8FF2")
    static let G1718_Center = Color(hex: "FFCC8C")
    static let G1718_Bottom = Color(hex: "FFE5BB")
    
    // 19시 ~ 20시 배경 색상
    static let G1920_Top = Color(hex: "344291")
    static let G1920_Center = Color(hex: "AC4F6A")
    static let G1920_Bottom = Color(hex: "F67E0D")
    
    // 21시 ~ 22시 배경 색상
    static let G2122_Top = Color(hex: "1A1F51")
    static let G2122_Center = Color(hex: "642E81")
    static let G2122_Bottom = Color(hex: "B938C2")
    
    // 23시 ~ 00시 배경 색상
    static let G2300_Top = Color(hex: "001634")
    static let G2300_Center = Color(hex: "421F6D")
    static let G2300_Bottom = Color(hex: "23006D")
    
    // 01시 ~ 02시 배경 색상
    static let G0102_Top = Color(hex: "000F25")
    static let G0102_Center = Color(hex: "1B2051")
    static let G0102_Bottom = Color(hex: "17296D")
    
    // 03시 ~ 04시 배경 색상
    static let G0304_Top = Color(hex: "183A68")
    static let G0304_Center = Color(hex: "1B2051")
    static let G0304_Bottom = Color(hex: "17296D")
}
