//
//  ScrollToTopTarget.swift
//  Solply
//
//  Created by 김승원 on 1/2/26.
//

import Foundation

enum ScrollToTopTarget: Equatable {
    case placeTopTarget
    case courseTopTarget
    case bookmarkTopTarget
    case myPageTopTarget
}

extension ScrollToTopTarget {
    static func from(_ tabBarState: TabBarState) -> ScrollToTopTarget {
        switch tabBarState {
        case .place: return .placeTopTarget
        case .course: return .courseTopTarget
        case .bookmark: return .bookmarkTopTarget
        case .myPage: return .myPageTopTarget
        }
    }
}
