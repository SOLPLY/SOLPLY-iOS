//
//  PersonaType.swift
//  Solply
//
//  Created by 선영주 on 7/10/25.
//

import Foundation

enum PersonaType: CaseIterable {
    case healing
    case explorer
    case mooding
    case natural
    
    var personaString: String {
        switch self {
        case .healing: return "조용한 공간에 오래 머물고 싶어요"
        case .explorer: return "이곳저곳 둘러보고 싶어요"
        case .mooding: return "취향이 담긴 곳을 찾고 싶어요"
        case .natural: return "자연을 감상하며 쉬고 싶어요"
        }
    }
    
    var apiString: String {
        switch self {
        case .healing: return "REST"
        case .explorer: return "EXPLORER"
        case .mooding: return "MOODING"
        case .natural: return "NATURAL"
        }
    }
}
