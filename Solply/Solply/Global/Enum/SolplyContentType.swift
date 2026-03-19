//
//  SolplyContentType.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

enum SolplyContentType: String, CaseIterable, Codable{
    case place
    case course
    
    var title: String {
        switch self {
        case .place: return "장소"
        case .course: return "코스"
        }
    }
    
    var apiValue: String {
        rawValue.uppercased()
    }
}

// MARK: - AI 추천 뷰

extension SolplyContentType {
    var modalType: ModalType {
        switch self {
        case .place:
            return .aiRecommendPlace
        case .course:
            return .aiRecommendCourse
        }
    }
    
    var aiRecommendPromptPlaceholder: String {
        switch self {
        case .place:
            return "작업하기 좋은 우드톤 카페\n시간 제한 없는 조용한 디저트 카페\n혼자 생각 정리하기 좋은 산책로"
        case .course:
            return "소품샵 중심 구경하기 좋은 코스\n평일 오후에 가기 좋은 반나절 코스 "
        }
    }
}
