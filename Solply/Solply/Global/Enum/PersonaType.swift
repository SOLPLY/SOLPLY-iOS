//
//  PersonaType.swift
//  Solply
//
//  Created by 선영주 on 7/10/25.
//

import Foundation

enum PersonaType: String, CaseIterable, ResponseModelType, RequestModelType{
    case healing = "REST"
    case explorer = "EXPLORER"
    case mooding = "MOODING"
    case natural = "NATURAL"
    
    var personaString: String {
        switch self {
        case .healing: return "조용한 공간에 오래 머물고 싶어요"
        case .explorer: return "이곳저곳 둘러보고 싶어요"
        case .mooding: return "취향이 담긴 곳을 찾고 싶어요"
        case .natural: return "자연을 감상하며 쉬고 싶어요"
        }
    }
    
    var description: String {
        switch self {
        case .healing: return "조용히 사색을 즐기는"
        case .explorer: return "골목 곳곳을 탐색하는"
        case .mooding: return "취향을 모으는"
        case .natural: return "힐링이 필요한"
        }
    }
}
