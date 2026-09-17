//
//  AIRecommendType.swift
//  Solply
//
//  Created by sun on 3/15/26.
//

import SwiftUI

enum AIRecommendType {
    case place(MainTagType)
    case course(CourseTagType)
    
    var icon: ImageResource? {
        switch self {
        case .place(let tag):
            return tag.aiIcon
        case .course(let tag):
            return tag.aiIcon
        }
    }
    
    // MARK: - Properties
    
    var titleColor: Color {
        switch self {
        case .place(let tag):
            return tag.titleColor ?? .coreBlack
        case .course(let tag):
            return tag.titleColor
        }
    }
}
