//
//  MapView.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/22.
//

import SwiftUI
 
struct MapView: View {
    @Binding var countryName: String
    @Binding var continent: String
    @Binding var locality: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                Text("지도")
                    .font(.system(size: 17, weight: .bold))
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        HapticManager.instance.impact(style: .light)
                        dismiss()
                    }, label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.clear)
                            
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundColor(.primary.opacity(0.2))
                        }
                    })
                }
            }
            
            MapFocusView(
                countryName: $countryName,
                locality: $locality
            )
            .frame(width: screenWidth * 0.92, height: 400)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
            VStack(alignment: .leading) {
                Text("\(countryName)")
                    .font(.system(size: locality == "" ? 28 : 20, weight: locality == "" ? .black : .light))
                    .foregroundColor(.primary)
                    .padding(.top, 20)
                
                Text("\(locality)")
                    .font(.system(size: 28, weight: .black))
                    .foregroundColor(.primary)
                
                Text("\(continent)")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.secondary)
                    .padding(.top, 4)
            }
            .frame(width: screenWidth * 0.92, alignment: .leading)
            .padding(.leading, 20)
            
            Spacer()
        } // VStack닫기
    } // body닫기
} // struct닫기
