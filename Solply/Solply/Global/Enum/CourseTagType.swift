//
//  CourseTagType.swift
//  Solply
//
//  Created by 김승원 on 2/14/26.
//

import SwiftUI

enum CourseTagType: String {
    case food = "맛집 · 디저트"
    case discovery = "취향 · 발견"
    case healing = "산책 · 힐링"
    case daily = "데일리"
    
    var title: String {
        switch self {
        case .food: return "맛집·디저트"
        case .discovery: return "취향·발견"
        case .healing: return "산책·힐링"
        case .daily: return "데일리"
        }
    }
    
    var tagBackgroundColor: Color {
        switch self {
        case .food: return .red50
        case .discovery: return .purple50
        case .healing: return .yellow50
        case .daily: return .green50
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .food: return .red50
        case .discovery: return .purple50
        case .healing: return .yellow50
        case .daily: return .green50
        }
    }
    
    var titleColor: Color {
        switch self {
        case .food: return .red500
        case .discovery: return .purple600
        case .healing: return .yellow500
        case .daily: return .green500
        }
    }
    
    var savedBadge: ImageResource {
        switch self {
        case .food: return .saveIconRed
        case .discovery: return .saveIconPurple
        case .healing: return .saveIconYellow
        case .daily: return .saveIconGreen
        }
    }
    
    var id: Int {
        switch self {
        case .food: return 31
        case .discovery: return 34
        case .healing: return 32
        case .daily: return 33
        }
    }
    
    var aiIcon: ImageResource? {
        switch self {
        case .food: return .aiIconRed
        case .discovery: return .aiIconPurple
        case .healing: return .aiIconYellow
        case .daily: return .aiIconGreen
        }
    }
}
