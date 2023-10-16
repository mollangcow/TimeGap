//
//  SettingView.swift
//  Pluminus
//
//  Created by kimsangwoo on 10/17/23.
//

import SwiftUI
import MessageUI

struct SettingView: View {
    @State private var isShowingEmailView = false
    @State private var emailResult: Result<MFMailComposeResult, Error>?
    
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
            
            VStack(alignment: .leading) {
                Text("지원")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
                    .padding(.leading, 20)
                
                Button(action: {
                    HapticManager.instance.impact(style: .light)
                    isShowingEmailView.toggle()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: screenWidth * 0.9 , height: 60)
                            .foregroundStyle(.gray.opacity(0.1))
                        HStack {
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.orange)
                            
                            Text("오류신고/문의하기")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.primary)
                                .padding(.leading, 8)
                            
                            Spacer()
                        }
                        .frame(width: screenWidth * 0.8 , height: 52)
                    }
                }
            }
            
            Spacer()
            
            Text("App Version 1.2.0")
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.secondary)
        }
        .sheet(isPresented: $isShowingEmailView) {
            EmailView(isShowing: $isShowingEmailView, result: $emailResult)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    SettingView()
}
