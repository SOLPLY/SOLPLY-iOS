//
//  AlertType.swift
//  Solply
//
//  Created by LEESOOYONG on 7/13/25.
//

import Foundation

enum AlertType {
    case delete
    case leave

    var mainText: String {
        switch self {
        case .delete: return "삭제"
        case .leave: return "나가기"
        }
    }
}
