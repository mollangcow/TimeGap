//
//  NC1App.swift
//  NC1
//
//  Created by kimsangwoo on 2023/06/01.
//

import SwiftUI

@main
struct NC1App: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
