//
//  DetailBottomSheetState.swift
//  Solply
//
//  Created by 김승원 on 7/14/25.
//

import Foundation

enum DetailBottomSheetState {
    case courseExpanded
    case placeExpended
    case collapsed
    
    var maxHeight: CGFloat {
        switch self {
        case .courseExpanded: return 423.adjustedHeight // 467 - 28 - 15
        case .placeExpended: return 487.adjustedHeight // 525 - 28 - 10
        case .collapsed: return 150.adjustedHeight
        }
    }
}
