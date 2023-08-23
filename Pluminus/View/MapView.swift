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
        VStack(alignment: .leading) {
            ZStack(alignment: .top) {
                MapFocusView(
                    countryName: $countryName,
                    locality: $locality
                )
                .frame(height: 500)
                .edgesIgnoringSafeArea(.all)
                
                HStack {
                    Spacer()
                    Button(action: {
                        HapticManager.instance.impact(style: .medium)
                        dismiss()
                    }, label: {
                        ZStack(alignment: .topTrailing) {
                            Rectangle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.clear)
                            Circle()
                                .frame(width: 28, height: 28)
                                .foregroundColor(.gray)
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundColor(.white)
                        }
                    })
                }
                .padding(.all, 20)
            } // ZStack닫기
            
            VStack(alignment: .leading) {
                Text("\(countryName)")
                    .font(.system(size: locality == "" ? 28 : 20, weight: locality == "" ? .black : .light))
                    .foregroundColor(.primary)
                    .padding(.top, 20)
                Text("\(locality)")
                    .font(.system(size: 28, weight: .black))
                    .foregroundColor(.primary)
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.gray.opacity(0.5))
                
                Text("\(continent)")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.secondary)
                    .padding(.top, 4)
            }
            .padding(.leading, 20)
            
            Spacer()
        } // VStack닫기
    } // body닫기
} // struct닫기
