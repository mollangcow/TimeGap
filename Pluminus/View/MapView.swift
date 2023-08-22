//
//  MapView.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/22.
//

import SwiftUI
 
struct MapView: View {
    @Binding var countryName: String

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .top) {
                MapFocusView(countryName: $countryName)
                .frame(height: 500)
                .edgesIgnoringSafeArea(.all)
                
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }, label: {
                        ZStack(alignment: .topTrailing) {
                            Rectangle()
                                .frame(width: 44, height: 44)
                                .foregroundColor(.clear)
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white.opacity(0.3))
                        }
                    })
                }
                .padding(.all, 20)
            } // ZStack닫기
            
            VStack(alignment: .leading) {
                Text("\(countryName)")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.primary)
                    .padding(.top, 20)
                
                Text("Location Date")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.primary)
                    .padding(.top, 4)
            }
            .padding(.leading, 20)
            
            Spacer()
        } // VStack닫기
    } // body닫기
} // struct닫기
