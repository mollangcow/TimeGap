//
//  test.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/08.
//

import SwiftUI

struct test: View {
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                showAlertWithMessage("Button 1 Pressed")
            }
            
            Button("Button 2") {
                showAlertWithMessage("Button 2 Pressed")
            }
            
            Button("Button 3") {
                showAlertWithMessage("Button 3 Pressed")
            }
            
            if showAlert {
                Text(alertMessage)
                    .background(Color.yellow)
                    .padding()
                    .transition(.move(edge: .top))
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private func showAlertWithMessage(_ message: String) {
        timer?.invalidate()
        
        alertMessage = message
        showAlert = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            withAnimation {
                showAlert = false
            }
        }
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
