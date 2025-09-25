//
//  CustomBottomSheetType.swift
//  Solply
//
//  Created by 김승원 on 8/4/25.
//

import Foundation

enum CustomBottomSheetType {
    
    // TODO: - 나중에 두 시트가 분리될 수 있기 때문에 남겨놓을게요
    
    case placeDetail
    case courseDetail(fromArchive: Bool)
    
    var defaultHeight: CGFloat {
        switch self {
        case .placeDetail, .courseDetail:
            return 495.adjustedHeight
        }
    }
    
    var maxHeight: CGFloat {
        switch self {
        case .placeDetail, .courseDetail:
            return 710.adjustedHeight
        }
    }
    
    var minHeight: CGFloat {
        switch self {
        case .placeDetail, .courseDetail:
            return 200.adjustedHeight
        }
    }
}
