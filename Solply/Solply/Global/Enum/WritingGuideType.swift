//
//  WritingGuideType.swift
//  Solply
//
//  Created by seozero on 3/12/26.
//

import Foundation

enum WritingGuideType {
    case place
    case course
    
    var title: String {
        return "이렇게 쓰면 더 정확해요"
    }
    
    var contents: [String] {
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
}
