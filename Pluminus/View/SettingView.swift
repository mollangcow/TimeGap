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
    
    @State private var isShowingEmailView = false
    @State private var emailResult: Result<MFMailComposeResult, Error>?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Help")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.primary)
                        .padding(.vertical, 20)
                    
                    Button {
                        HapticManager.instance.impact(style: .light)
                        isShowingEmailView.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.orange)
                                .padding(.leading, 20)
                            
                            Text("Send Email to Developer")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.primary)
                                .padding(.leading, 8)
                            
                            Spacer()
                        }
                        .frame(height: 60)
                        .background(.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    
                    Text("General")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.primary)
                        .padding(.vertical, 20)
                    
                    HStack {
                        Image(systemName: "moon.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.orange)
                            .padding(.leading, 20)
                        
                        Toggle(isOn: $isDarkMode, label: {
                            Text("Dark Mode")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.primary)
                                .padding(.leading, 8)
                        })
                        .toggleStyle(SwitchToggleStyle(tint: .orange))
                        .padding(.trailing, 20)
                    }
                    .frame(height: 60)
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .navigationTitle("Setting")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        HapticManager.instance.impact(style: .light)
                        dismiss()
                    } label: {
                        ZStack(alignment: .trailing) {
                            Rectangle()
                                .frame(width: 44, height: 44)
                                .foregroundColor(.clear)
                            
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .bold()
                                .foregroundColor(.orange)
                        }
                    }
                }
            } // toolbar
        } // NavigationStack
        .sheet(isPresented: $isShowingEmailView) {
            EmailView(isShowing: $isShowingEmailView, result: $emailResult)
                .ignoresSafeArea()
        } //sheet
        .preferredColorScheme(isDarkMode ? .dark : .light)
    } //body
} //struct
