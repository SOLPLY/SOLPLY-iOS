//
//  SocialLoginType.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import SwiftUI

enum SocialLoginType: String, Equatable {
    case kakao = "KAKAO"
    case apple = "APPLE"
}

// MARK: - SocialLoginButtonStyle

extension SocialLoginType {
    var buttonIcon: ImageResource {
        switch self {
        case .kakao: return .kakaoTalkIcon
        case .apple: return .appleLogo
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .kakao: return "카카오로 시작하기"
        case .apple: return "Apple로 시작하기"
        }
    }
    
    var buttonTitleColor: Color {
        switch self {
        case .kakao: return Color(red: 0.1, green: 0.1, blue: 0.1)
        case .apple: return .coreWhite
        }
    }
    
    var buttonBackgroundColor: Color {
        switch self {
        case .kakao: return Color(red: 1, green: 0.9, blue: 0)
        case .apple: return .black
        }
    }
}
