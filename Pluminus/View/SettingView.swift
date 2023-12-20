//
//  SettingView.swift
//  Pluminus
//
//  Created by kimsangwoo on 10/17/23.
//

import SwiftUI
import MessageUI

struct SettingView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @Environment(\.dismiss) var dismiss
    
    @State private var isShowingEmailView = false
    @State private var emailResult: Result<MFMailComposeResult, Error>?
    
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
                        HStack {
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.orange)
                                .padding(.leading, 20)
                            
                            Text("오류 문의하기")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.primary)
                                .padding(.leading, 8)
                            
                            Spacer()
                        }
                        .frame(width: screenWidth * 0.88 , height: 60)
                        .background(.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                
                Text("일반")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
                    .padding(.leading, 20)
                    .padding(.top, 20)

                HStack {
                    Image(systemName: "moon.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.orange)
                        .padding(.leading, 20)
                    
                    Toggle(isOn: $isDarkMode, label: {
                        Text("어두운 화면")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.primary)
                            .padding(.leading, 8)
                    })
                    .toggleStyle(SwitchToggleStyle(tint: .orange))
                    .padding(.trailing, 20)
                }
                .frame(width: screenWidth * 0.88 , height: 60)
                .background(.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            
            Spacer()
            
            Text("App Version 1.2.0")
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.secondary)
        }
        .sheet(isPresented: $isShowingEmailView) {
            EmailView(isShowing: $isShowingEmailView, result: $emailResult)
                .ignoresSafeArea()
        } //sheet
        .preferredColorScheme(isDarkMode ? .dark : .light)
    } //body
} //struct

#Preview {
    SettingView()
}
