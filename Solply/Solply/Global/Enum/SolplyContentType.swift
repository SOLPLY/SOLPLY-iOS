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
    var aiRecommendGuideTitle: String {
        return "이렇게 쓰면 더 정확해요"
    }
    
    var aiRecommendGuideContents: [String] {
        switch self {
        case .place:
            return [
                "동네(지역) + 분위기 + 활동을 함께 적으면 더 정확해요",
                "예: “연남에서 조용한 우드톤 카페, 오래 머물 수 있는 곳”",
                "원하는 좌석 또는 환경(창가, 조용함 등)을 적어도 좋아요"
            ]
        case .course:
            return [
                "코스에 포함되길 원하는 장소들을 적어주세요",
                "선호하는 장소 개수(2~4개)를 알려주세요",
                "선호하는 분위기와 활동을 함께 적어주세요"
            ]
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
