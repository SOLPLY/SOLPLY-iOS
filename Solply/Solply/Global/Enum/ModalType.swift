//
//  ModalType.swift
//  Solply
//
//  Created by seozero on 3/17/26.
//

import Foundation

enum ModalType {
    case aiRecommendPlace
    case aiRecommendCourse
}

// MARK: - AI 추천 뷰

extension ModalType {
    var aiRecommendGuideTitle: String {
        return "이렇게 쓰면 더 정확해요"
    }
    
    var aiRecommendGuideContents: [String] {
        switch self {
        case .aiRecommendPlace:
            return [
                "동네(지역) + 분위기 + 활동을 함께 적으면 더 정확해요",
                "예: “연남에서 조용한 우드톤 카페, 오래 머물 수 있는 곳”",
                "원하는 좌석 또는 환경(창가, 조용함 등)을 적어도 좋아요"
            ]
            
        case .aiRecommendCourse:
            return [
                "코스에 포함되길 원하는 장소들을 적어주세요",
                "선호하는 장소 개수(2~4개)를 알려주세요",
                "선호하는 분위기와 활동을 함께 적어주세요"
            ]
        }
    }
}
