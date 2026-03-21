//
//  MyPageSectionType.swift
//  Solply
//
//  Created by sun on 3/19/26.
//

import SwiftUI

enum MyPageSectionType {
    case registeredPlaces
    case record
    
    var title: String {
        switch self {
        case .registeredPlaces:
            return "내가 등록한 장소"
        case .record:
            return "내 솔플리 기록"
        }
    }
    
    var emptyText: String {
        switch self {
        case .registeredPlaces:
            return "등록한 장소가 없어요"
        case .record:
            return "등록한 기록이 없어요"
        }
    }
}
