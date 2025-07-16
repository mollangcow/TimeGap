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
    static let G0001_Top = Color(hex: "000924")
    static let G0001_Center = Color(hex: "00084B")
    static let G0001_Bottom = Color(hex: "001153")
    
    // 02시 ~ 03시 배경 색상
    static let G0203_Top = Color(hex: "00045B")
    static let G0203_Center = Color(hex: "0D176E")
    static let G0203_Bottom = Color(hex: "2B2283")
    
    // 04시 ~ 05시 배경 색상
    static let G0405_Top = Color(hex: "4A7BFF")
    static let G0405_Center = Color(hex: "8F87FF")
    static let G0405_Bottom = Color(hex: "F05D5D")
    
    // 06시 ~ 07시 배경 색상
    static let G0607_Top = Color(hex: "5785DC")
    static let G0607_Center = Color(hex: "B49FE6")
    static let G0607_Bottom = Color(hex: "FFC260")
    
    // 08시 ~ 09시 배경 색상
    static let G0809_Top = Color(hex: "6AB0FF")
    static let G0809_Center = Color(hex: "D2D2FF")
    static let G0809_Bottom = Color(hex: "DDE0FF")
    
    // 10시 ~ 11시 배경 색상
    static let G1011_Top = Color(hex: "8FCEFF")
    static let G1011_Center = Color(hex: "B2D3FF")
    static let G1011_Bottom = Color(hex: "D8DEFF")
    
    // 12시 ~ 13시 배경 색상
    static let G1213_Top = Color(hex: "BCE2FF")
    static let G1213_Center = Color(hex: "A9DAFF")
    static let G1213_Bottom = Color(hex: "A3DCFF")
    
    // 14시 ~ 15시 배경 색상
    static let G1415_Top = Color(hex: "579FFF")
    static let G1415_Center = Color(hex: "85DDFF")
    static let G1415_Bottom = Color(hex: "E7F2FF")
    
    // 16시 ~ 17시 배경 색상
    static let G1617_Top = Color(hex: "5A8FF2")
    static let G1617_Center = Color(hex: "8CCBFF")
    static let G1617_Bottom = Color(hex: "FFE5BB")
    
    // 18시 ~ 19시 배경 색상
    static let G1819_Top = Color(hex: "203CD6")
    static let G1819_Center = Color(hex: "765DBF")
    static let G1819_Bottom = Color(hex: "F67A0D")
    
    // 20시 ~ 21시 배경 색상
    static let G2021_Top = Color(hex: "0A1473")
    static let G2021_Center = Color(hex: "3325BB")
    static let G2021_Bottom = Color(hex: "8138C2")
    
    // 22시 ~ 23시 배경 색상
    static let G2223_Top = Color(hex: "00052D")
    static let G2223_Center = Color(hex: "1A104A")
    static let G2223_Bottom = Color(hex: "32009C")
}
