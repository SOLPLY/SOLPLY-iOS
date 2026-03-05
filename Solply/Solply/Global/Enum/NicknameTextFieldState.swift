//
//  NicknameType.swift
//  Solply
//
//  Created by 선영주 on 7/11/25.
//

import SwiftUI

enum NicknameTextFieldState {
    case placeholder
    case editing
    case valid
    case duplicate
    case invalidCharacter
    case shouldTwoCharacter

    var borderColor: Color {
        switch self {
        case .valid:
            return .green500
        case .duplicate, .invalidCharacter, .shouldTwoCharacter:
            return .red500
        default:
            return .gray300
        }
    }

    var icon: Image? {
        switch self {
        case .valid:
            return Image(.successIcon)
        case .duplicate, .invalidCharacter, .shouldTwoCharacter:
            return Image(.errorIcon)
        default:
            return nil
        }
    }

    var guidance: (text: String, color: Color)? {
        switch self {
        case .valid:
            return ("사용 가능한 이름이에요.", .green500)
        case .duplicate:
            return ("중복된 이름이에요.", .red500)
        case .invalidCharacter:
            return ("사용할 수 없는 문자가 있어요.", .red500)
        case .shouldTwoCharacter:
            return ("두 글자 이상이어야 해요.", .red500)
        default:
            return nil
        }
    }
}
