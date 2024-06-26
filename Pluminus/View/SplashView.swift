//
//  SplashView.swift
//  Pluminus
//
//  Created by kimsangwoo on 6/26/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            Image("SplashIcon")
                .resizable()
                .frame(width: 60, height: 60)
        }
    }
}
