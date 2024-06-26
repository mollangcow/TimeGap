//
//  MapView.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/22.
// test

import SwiftUI
 
struct NationInfoMapView: View {
    @Binding var countryName: String
    @Binding var continent: String
    @Binding var locality: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
            MapView(
                countryName: $countryName,
                locality: $locality
            )
            
            VStack {
                HStack {
                    Spacer()
                    
                    // dismiss button
                    Button {
                        HapticManager.instance.impact(style: .light)
                        dismiss()
                    } label: {
                        Rectangle()
                            .foregroundStyle(.clear)
                            .background(.ultraThickMaterial)
                            .clipShape(Circle())
                            .overlay {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .bold()
                                    .foregroundStyle(.orange)
                                    .frame(width: 12, height: 12)
                            }
                            .frame(width: 28, height: 28)
                            .padding(.all, 24)
                    } // button
                }
                
                Spacer()
                
                // information card
                VStack {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("\(countryName)")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.orange)
                            
                            Text("\(locality)")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.primary)
                        }
                        
                        Spacer()
                        
                        Text("\(continent)")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.secondary)
                    }
                    .padding(.all, 24)
                } // VStack
                .padding(.bottom, 40)
                .background(.thickMaterial)
            } // VStack
        } // ZStack
        .ignoresSafeArea()
    } // body
} // struct
