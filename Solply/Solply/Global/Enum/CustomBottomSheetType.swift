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
        case .placeDetail, .courseDetail:
            return 270.adjustedHeight
        }
    }
    
    var maxOffset: CGFloat {
        switch self {
        case .placeDetail, .courseDetail:
            return 50.adjustedHeight
        }
    }
    
    var minOffset: CGFloat {
        switch self {
        case .placeDetail, .courseDetail:
            return 530.adjustedHeight
        }
    }
    
    var maxThreshold: CGFloat {
        return 50.adjustedHeight
    }
    
    var minThreshold: CGFloat {
        return 150.adjustedHeight
    }
}
