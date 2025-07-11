//
//  NicknameType.swift
//  Solply
//
//  Created by 선영주 on 7/11/25.
//

import SwiftUI

enum NicknameState {
    case placeholder
    case editing
    case valid
    case duplicate
    case invalidCharacter

    var borderColor: Color {
        switch self {
        case .valid:
            return .green500
        case .duplicate, .invalidCharacter:
            return .red500
        default:
            return .gray300
        }
    }

    var icon: Image? {
        switch self {
        case .valid:
            return Image("success-icon")
        case .duplicate, .invalidCharacter:
            return Image("error-icon")
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
        default:
            return nil
        }
    }
}
