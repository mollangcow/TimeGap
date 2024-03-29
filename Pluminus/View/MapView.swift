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
                        ZStack {
                            Rectangle()
                                .frame(width: 60, height: 60)
                                .foregroundStyle(.clear)
                            Circle()
                                .frame(width: 28, height: 28)
                                .foregroundStyle(.clear)
                                .background(.regularMaterial)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(.regularMaterial, lineWidth: 1)
                            )
                            Image(systemName: "xmark")
                                .resizable()
                                .bold()
                                .foregroundStyle(.orange)
                                .frame(width: 12, height: 12)
                        }
                    })
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("\(countryName)")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.primary)
                        
                        Text("\(locality)")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.secondary)
                            .padding(.bottom, 8)
                        
                        Text("\(continent)")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 24)
                }
                .frame(width: screenWidth, alignment: .leading)
                .padding(.bottom, 60)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.regularMaterial, lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.2), radius: 20)
            } //VStack
        } // ZStack
        .ignoresSafeArea()
    } // body
} // struct
