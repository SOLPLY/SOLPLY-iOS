//
//  HapticManager.swift
//  Solply
//
//  Created by 김승원 on 12/12/25.
//

import SwiftUI

final class HapticManager {
    
    static let shared = HapticManager()
    private init() {}
    
    /// 지정한 타입의 알림 햅틱을 발생시킵니다.
    /// - Parameter type: `.success`, `.warning`, `.error`
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    /// 지정한 타입의 임팩트 햅틱을 발생시킵니다.
    /// - Parameter style: `.light`, `.medium`, `.heavy`, `.soft`, `.rigid`
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
