//
//  PlaceCategoryType.swift
//  Solply
//
//  Created by seozero on 7/8/25.
//

import SwiftUI

enum PlaceCategoryType {
    case all
    case cafe
    case food
    case book
    case shopping
    case walk
    case unique
    
    var title: String {
        switch self {
        case .all: return "전체"
        case .cafe: return "카페"
        case .food: return "음식"
        case .book: return "서점/책방"
        case .shopping: return "쇼핑"
        case .walk: return "산책"
        case .unique: return "이색공간"
        }
    }
    
    var backgroundColor: Color? {
        switch self {
        case .all: return nil
        case .cafe: return .red100
        case .food: return .yellow100
        case .book: return .purple100
        case .shopping: return .purple100
        case .walk: return .green100
        case .unique: return .green100
        }
    }
    
    var titleColor: Color? {
        switch self {
        case .all: return nil
        case .cafe: return .red500
        case .food: return .yellow500
        case .book: return .purple600
        case .shopping: return .purple600
        case .walk: return .green500
        case .unique: return .green500
        }
    }
}
