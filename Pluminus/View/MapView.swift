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
                        }
                    })
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(countryName)")
                        .font(.system(size: locality == "" ? 28 : 20, weight: locality == "" ? .black : .light))
                        .foregroundColor(.primary)
                    
                    Text("\(locality)")
                        .font(.system(size: 28, weight: .black))
                        .foregroundColor(.primary)
                    
                    Text("\(continent)")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.secondary)
                }
                .frame(width: screenWidth * 0.88, alignment: .leading)
                .padding(.leading, 20)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.thickMaterial, lineWidth: 1)
                )
                .padding(.bottom, 60)
            } //VStack
        } // VStack
        .ignoresSafeArea()
    } // body
} // struct
