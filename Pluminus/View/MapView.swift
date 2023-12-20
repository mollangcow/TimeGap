//
//  MapView.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/22.
// test

import SwiftUI
 
struct MapView: View {
    @Binding var countryName: String
    @Binding var continent: String
    @Binding var locality: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
            MapFocusView(
                countryName: $countryName,
                locality: $locality
            )
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        HapticManager.instance.impact(style: .light)
                        dismiss()
                    }, label: {
                        Rectangle()
                            .frame(width: 60, height: 60)
                            .foregroundStyle(.clear)
                            .background(.thickMaterial)
                            .mask(
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                            )
                            .overlay(
                                Circle()
                                    .stroke(.ultraThickMaterial, lineWidth: 1)
                                    .frame(width: 28, height: 28)
                            )
                            .shadow(color: .black.opacity(0.3), radius: 10)
                    })
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(countryName)")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.primary)
                        .padding(.bottom, 8)
                    
                    Text("\(locality)")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.secondary)
                        .padding(.bottom, 8)
                    
                    Text("\(continent)")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.secondary)
                }
                .frame(width: screenWidth * 0.88, alignment: .leading)
                .padding(.leading, 20)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.regularMaterial, lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.2), radius: 20)
                .padding(.bottom, 80)
            } //VStack
        } // VStack
        .ignoresSafeArea()
    } // body
} // struct
