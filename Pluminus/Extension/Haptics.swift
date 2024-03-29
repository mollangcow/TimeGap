//
//  Haptics.swift
//  Pluminus
//
//  Created by kimsangwoo on 2023/08/23.
//

//  "SUCCESS" { hapticManager.notification(type: .success) }
//  "WARNING" { hapticManager.notification(type: .warning) }
//  "ERROR" { hapticManager.notification(type: .error) }
//  "SOFT" { hapticManager.impact(style: .soft) }
//  "LIGHT" { hapticManager.impact(style: .light) }
//  "MEDIUM" { hapticManager.impact(style: .medium) }
//  "RIGID" { hapticManager.impact(style: .rigid) }
//  "HEAVY" { hapticManager.impact(style: .heavy) }

import SwiftUI

class HapticManager {
    static let instance = HapticManager()
    private init() {}
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
