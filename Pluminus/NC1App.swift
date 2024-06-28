//
//  NC1App.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/01.
//

import SwiftUI

@main
struct NC1App: App {
    @StateObject private var colorSchemeManager = ColorSchemeManager()

    var body: some Scene {
        WindowGroup {
            Group {
                MainView()
            }
            .environmentObject(colorSchemeManager)
            .onAppear {
                colorSchemeManager.setttingDisplayColorMode()
            }
        }
    }
}
