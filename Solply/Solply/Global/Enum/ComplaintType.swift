//
//  ComplaintType.swift
//  Solply
//
//  Created by LEESOOYONG on 3/18/26.
//

import Foundation

enum ComplaintType: String, CaseIterable {
    
    case irrelevantContent = "IRRELEVANT_CONTENT"
    case abusiveLanguage = "ABUSIVE_LANGUAGE"
    case privacyViolation = "PRIVACY_VIOLATION"
    case falseInformation = "FALSE_INFORMATION"
    case others = "OTHERS"
    
    var title: String {
        switch self {
        case .irrelevantContent: return "장소와 무관한 내용이에요"
        case .abusiveLanguage: return "욕설/비방이 포함되어 있어요"
        case .privacyViolation: return "타인의 얼굴/개인정보가 노출되었어요"
        case .falseInformation: return "허위 정보가 포함되어 있어요"
        case .others: return "기타(직접 입력)"
        }
    }
}
