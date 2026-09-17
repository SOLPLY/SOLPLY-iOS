//
//  MainTagType.swift
//  Solply
//
//  Created by seozero on 7/8/25.
//

import SwiftUI

enum MainTagType: String, CaseIterable, Identifiable, ResponseModelType, RequestModelType {
    case all = "전체"
    case cafe = "카페"
    case food = "음식"
    case shopping = "쇼핑"
    case book = "서점/책방"
    case unique = "이색공간"
    case walk = "산책"
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .all: return "전체"
        case .cafe: return "카페"
        case .food: return "음식"
        case .shopping: return "쇼핑"
        case .book: return "서점/책방"
        case .unique: return "이색공간"
        case .walk: return "산책"
        }
    }
    
    var backgroundColor: Color? {
        switch self {
        case .all: return nil
        case .cafe: return .red50
        case .food: return .yellow50
        case .shopping: return .purple50
        case .book: return .purple50
        case .unique: return .green50
        case .walk: return .green50
        }
    }
    
    var titleColor: Color? {
        switch self {
        case .all: return nil
        case .cafe: return .red500
        case .food: return .yellow500
        case .shopping: return .purple500
        case .book: return .purple500
        case .unique: return .green500
        case .walk: return .green500
        }
    }
    
    var savedBadge: String? {
        switch self {
        case .all: return nil
        case .cafe: return "save-icon-red"
        case .food: return "save-icon-yellow"
        case .shopping: return "save-icon-purple"
        case .book: return "save-icon-purple"
        case .unique: return "save-icon-green"
        case .walk: return "save-icon-green"
        }
    }
    
    var courseBackgroundColor: Color? {
        switch self {
        case .all: return nil
        case .cafe: return .red300
        case .food: return .yellow200
        case .shopping: return .purple300
        case .book: return .purple300
        case .unique: return .green300
        case .walk: return .green300
        }
    }
    
    var icon: ImageResource {
        switch self {
        case .all: return .allIcon
        case .cafe: return .cafeIcon
        case .food: return .foodIcon
        case .shopping: return .shopIcon
        case .book: return .bookIcon
        case .unique: return .uniqueIcon
        case .walk: return .walkIcon
        }
    }
    
    var parentId: Int {
        switch self {
        case .all: return 0
        case .cafe: return 1
        case .food: return 2
        case .shopping: return 3
        case .book: return 4
        case .unique: return 5
        case .walk: return 6
        }
    }
    
    var aiIcon: ImageResource? {
        switch self {
        case .all: return nil
        case .cafe: return .aiIconRed
        case .food: return .aiIconYellow
        case .shopping: return .aiIconPurple
        case .book: return .aiIconPurple
        case .unique: return .aiIconGreen
        case .walk: return .aiIconGreen
        }
    }
}
