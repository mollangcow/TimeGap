//
//  SettingView.swift
//  Pluminus
//
//  Created by kimsangwoo on 10/17/23.
//

import SwiftUI
import MessageUI

enum ColorScheme: Int {
    case unspecified, light, dark
}

class ColorSchemeManager: ObservableObject {
    @AppStorage("Color?Scheme") var colorScheme: ColorScheme = .unspecified {
        didSet {
            setttingDisplayColorMode()
        }
    }
    
    func setttingDisplayColorMode() {
        keyWindow?.overrideUserInterfaceStyle = UIUserInterfaceStyle(
            rawValue: colorScheme.rawValue
        )!
    }
    
    var keyWindow: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
                  return nil
              }
        
        return window
    }
}

private enum ColorSchemeType: String, CaseIterable {
    case device
    case light
    case dark
    
    var title: String {
        switch self {
        case .device: return "Device"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }
    
    var theme: ColorScheme {
        switch self {
        case .device: return ColorScheme.unspecified
        case .light: return ColorScheme.light
        case .dark: return ColorScheme.dark
        }
    }
    
    var asset: String {
        switch self {
        case .device: return "display.device"
        case .light: return "display.light"
        case .dark: return "display.dark"
        }
    }
}

struct SettingView: View {
    @State private var isShowingEmailView = false
    @State private var emailResult: Result<MFMailComposeResult, Error>?
    
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("Color?Scheme") var colorScheme: ColorScheme = .unspecified
    @EnvironmentObject var colorSchemeManager: ColorSchemeManager
    @State private var selectedTheme: ColorScheme = .dark
    
    var body: some View {
        NavigationStack {
            // ToolBar
            HStack {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundStyle(Color.orange)
                    .padding(.top, 2)
                
                Text("Setting")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.primary)
                    .padding(.leading, 4)
                
                Spacer()
                
                Button {
                    HapticManager.instance.impact(style: .medium)
                    dismiss()
                } label: {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(Color.secondary.opacity(0.1))
                        .background(
                            Rectangle()
                                .frame(width: 44, height: 44)
                                .foregroundStyle(Color.clear)
                        )
                        .overlay {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 14, height: 14)
                                .bold()
                                .foregroundStyle(Color.orange)
                        }
                }
            } // HStack
            
            VStack {
                HStack {
                    Text("Help")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.primary)
                        .padding(.top, 12)
                        .padding(.leading, 8)
                    
                    Spacer()
                } // HStack
                
                Button {
                    HapticManager.instance.impact(style: .light)
                    isShowingEmailView.toggle()
                } label: {
                    HStack(spacing: 0) {
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundStyle(Color.orange)
                        
                        Text("Send Email to Developer")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.primary)
                            .padding(.leading, 16)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.all, 20)
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                } // Button
                
                HStack {
                    Text("Theme")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.primary)
                        .padding(.top, 32)
                        .padding(.leading, 8)
                    
                    Spacer()
                } // HStack
                
                HStack {
                    ForEach(ColorSchemeType.allCases, id: \.self) { type in
                        VStack(spacing: 0) {
                            Image(type.asset)
                                .resizable()
                                .scaledToFit()
                                .padding(.all, 8)
                            
                            HStack {
                                if selectedTheme == type.theme {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 17))
                                        .foregroundStyle(Color.orange)
                                } else {
                                    Image(systemName: "circle")
                                        .font(.system(size: 17))
                                        .foregroundStyle(Color.secondary)
                                }
                                
                                Text(type.title)
                                    .font(.system(size: 17, weight: .bold))
                            }
                            .padding(.bottom, 12)
                        } // VStack
                        .frame(maxWidth: .infinity)
                        .background(.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay {
                            if selectedTheme == type.theme {
                                RoundedRectangle(cornerRadius: 20)
                                    .strokeBorder(lineWidth: 2)
                                    .foregroundStyle(Color.orange)
                            } else {
                                EmptyView()
                            }
                        }
                        .onTapGesture {
                            HapticManager.instance.impact(style: .light)
                            withAnimation {
                                selectedTheme = type.theme
                                colorSchemeManager.colorScheme = selectedTheme
                            }
                        }
                    }
                } // HStack
            } // VStack
            
            Spacer()
        }
        .padding(.all, 20)
        .onAppear {
            selectedTheme = colorSchemeManager.colorScheme
        }
        .sheet(isPresented: $isShowingEmailView) {
            EmailView(isShowing: $isShowingEmailView, result: $emailResult)
                .presentationDetents([.large])
                .presentationCornerRadius(32)
                .edgesIgnoringSafeArea(.bottom)
        }
    } //body
} //struct
