//
//  CustomBottomSheetType.swift
//  Solply
//
//  Created by 김승원 on 8/4/25.
//

import Foundation

enum CustomBottomSheetType {
    case placeDetail
    case courseDetail(fromArchive: Bool)
    
    var defaultOffset: CGFloat {
        switch self {
        case .placeDetail:
            return 190.adjustedHeight
        case .courseDetail(let fromArchive):
            return fromArchive ? 290.adjustedHeight : 240.adjustedHeight
        }
    }
    
    var maxOffset: CGFloat {
        switch self {
        case .placeDetail:
            return -60.adjustedHeight
        case .courseDetail(let fromArchive):
            return fromArchive ? 36.adjustedHeight : 50.adjustedHeight
        }
    }
    
    var minOffset: CGFloat {
        switch self {
        case .placeDetail:
            return 600.adjustedHeight
        case .courseDetail(let fromArchive):
            return fromArchive ? 660.adjustedHeight :600.adjustedHeight
        }
    }
    
    var maxThreshold: CGFloat {
        return 50.adjustedHeight
    }
    
    var minThreshold: CGFloat {
        return 150.adjustedHeight
    }
}
