//
//  CourseTagType.swift
//  Solply
//
//  Created by 김승원 on 2/14/26.
//

import SwiftUI

enum CourseTagType: String {
    case food = "맛집, 디저트"
    case discovery = "취향, 발견"
    case healing = "산책, 힐링"
    case daily = "데일리"
    
    var id: Int {
        switch self {
        case .food: return 1
        case .discovery: return 2
        case .healing: return 3
        case .daily: return 4
        }
    }
    
    var title: String {
        switch self {
        case .food: return "맛집·디저트"
        case .discovery: return "취향·발견"
        case .healing: return "산책·힐링"
        case .daily: return "데일리"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .food: return .red100
        case .discovery: return .yellow100
        case .healing: return .purple100
        case .daily: return .green100
        }
    }
    
    var titleColor: Color {
        switch self {
        case .food: return .red500
        case .discovery: return .yellow500
        case .healing: return .purple600
        case .daily: return .green500
        }
    }
    
    var savedBadge: ImageResource {
        switch self {
        case .food: return .saveIconRed
        case .discovery: return .saveIconYellow
        case .healing: return .saveIconPurple
        case .daily: return .saveIconGreen
        }
    }
}
