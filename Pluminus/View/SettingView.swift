//
//  SettingView.swift
//  Pluminus
//
//  Created by kimsangwoo on 10/17/23.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ZStack {
                Text("설정")
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
            .padding(.top, 4)
            
            Spacer()
        }
    }
}

#Preview {
    SettingView()
}
