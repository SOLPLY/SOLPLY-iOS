//
//  WithdrawType.swift
//  Solply
//
//  Created by LEESOOYONG on 10/11/25.
//

import Foundation

enum WithdrawType: String, CaseIterable {
    case notUse = "NOT_USE"
    case deficientInfo = "DEFICIENT_INFO"
    case inconvenient = "INCONVENIENT"
    case hateRecommend = "HATE_RECOMMEND"
    case useOtherService = "USE_OTHER_SERVICE"
    case others = "OTHERS"
    
    var title: String {
        switch self {
        case .notUse: return "자주 사용하지 않아서"
        case .deficientInfo: return "원하는 지역과 장소가 부족해서"
        case .inconvenient: return "앱 기능이 불편해서"
        case .hateRecommend: return "추천 콘텐츠가 나와 맞지 않아서"
        case .useOtherService: return "다른 서비스를 사용하고 있습니다."
        case .others: return "기타 (직접 입력)"
        }
    }
}
