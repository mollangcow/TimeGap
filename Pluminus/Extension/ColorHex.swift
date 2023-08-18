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
    
    // 00시 ~ 01시 배경 색상
    static let G0001_Top = Color(hex: "000F25")
    static let G0001_Center = Color(hex: "1B2051")
    static let G0001_Bottom = Color(hex: "17296D")
    
    // 02시 ~ 03시 배경 색상
    static let G0203_Top = Color(hex: "183A68")
    static let G0203_Center = Color(hex: "1B2051")
    static let G0203_Bottom = Color(hex: "17296D")
    
    // 04시 ~ 05시 배경 색상
    static let G0405_Top = Color(hex: "3453A5")
    static let G0405_Center = Color(hex: "AC5BB6")
    static let G0405_Bottom = Color(hex: "F05D5D")
    
    // 06시 ~ 07시 배경 색상
    static let G0607_Top = Color(hex: "5785DC")
    static let G0607_Center = Color(hex: "DF9FE6")
    static let G0607_Bottom = Color(hex: "FFC260")
    
    // 08시 ~ 09시 배경 색상
    static let G0809_Top = Color(hex: "80BCFF")
    static let G0809_Center = Color(hex: "E5D2FF")
    static let G0809_Bottom = Color(hex: "DDE0FF")
    
    // 10시 ~ 11시 배경 색상
    static let G1011_Top = Color(hex: "8FCEFF")
    static let G1011_Center = Color(hex: "D2E5FF")
    static let G1011_Bottom = Color(hex: "C5E4FF")
    
    // 12시 ~ 13시 배경 색상
    static let G1213_Top = Color(hex: "67C1FF")
    static let G1213_Center = Color(hex: "CDF1FF")
    static let G1213_Bottom = Color(hex: "F0FBFF")
    
    // 14시 ~ 15시 배경 색상
    static let G1415_Top = Color(hex: "579FFF")
    static let G1415_Center = Color(hex: "B3EAFF")
    static let G1415_Bottom = Color(hex: "E7F2FF")
    
    // 16시 ~ 17시 배경 색상
    static let G1617_Top = Color(hex: "5A8FF2")
    static let G1617_Center = Color(hex: "FFCC8C")
    static let G1617_Bottom = Color(hex: "FFE5BB")
    
    // 18시 ~ 19시 배경 색상
    static let G1819_Top = Color(hex: "344291")
    static let G1819_Center = Color(hex: "AC4F6A")
    static let G1819_Bottom = Color(hex: "F67E0D")
    
    // 20시 ~ 21시 배경 색상
    static let G2021_Top = Color(hex: "1A1F51")
    static let G2021_Center = Color(hex: "642E81")
    static let G2021_Bottom = Color(hex: "B938C2")
    
    // 22시 ~ 23시 배경 색상
    static let G2223_Top = Color(hex: "001634")
    static let G2223_Center = Color(hex: "421F6D")
    static let G2223_Bottom = Color(hex: "23006D")
}
