//
//  PlaceCategoryType.swift
//  Solply
//
//  Created by seozero on 7/8/25.
//

import SwiftUI

enum PlaceCategoryType: String, CaseIterable, Identifiable, ResponseModelType, RequestModelType {
    case all = "ALL"
    case cafe = "CAFE"
    case food = "FOOD"
    case book = "BOOK"
    case shopping = "SHOPPING"
    case unique = "UNIQUE_SPACE"
    case walk = "WALKING"

    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .all: return "전체"
        case .cafe: return "카페"
        case .food: return "음식"
        case .book: return "서점/책방"
        case .shopping: return "쇼핑"
        case .unique: return "이색공간"
        case .walk: return "산책"
        }
    }
    
    var backgroundColor: Color? {
        switch self {
        case .all: return nil
        case .cafe: return .red100
        case .food: return .yellow100
        case .book: return .purple100
        case .shopping: return .purple100
        case .unique: return .green100
        case .walk: return .green100
        }
    }
    
    var titleColor: Color? {
        switch self {
        case .all: return nil
        case .cafe: return .red500
        case .food: return .yellow500
        case .book: return .purple600
        case .shopping: return .purple600
        case .unique: return .green500
        case .walk: return .green500
        }
    }
    
    var savedBadge: String? {
        switch self {
        case .all: return nil
        case .cafe: return "save-icon-red"
        case .food: return "save-icon-yellow"
        case .book: return "save-icon-purple"
        case .shopping: return "save-icon-purple"
        case .unique: return "save-icon-green"
        case .walk: return "save-icon-green"
        }
    }
    
    var courseBackgroundColor: Color? {
        switch self {
        case .all: return nil
        case .cafe: return .red300
        case .food: return .yellow200
        case .book: return .purple300
        case .shopping: return .purple300
        case .unique: return .green300
        case .walk: return .green300
        }
    }
    
    var icon: ImageResource {
        switch self {
        case .all: return .allIcon
        case .cafe: return .cafeIcon
        case .food: return .foodIcon
        case .book: return .bookIcon
        case .shopping: return .shopIcon
        case .unique: return .uniqueIcon
        case .walk: return .walkIcon
        }
    }
}
