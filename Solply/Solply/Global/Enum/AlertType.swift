//
//  AlertType.swift
//  Solply
//
//  Created by LEESOOYONG on 7/13/25.
//

import Foundation

enum AlertType {
    case deletePlace
    case deleteCourse
    case changesNotSaved
    case photoPermissionDenied
    case logout
    case withdraw
    case authenticationRequired
    
    var title: String {
        switch self {
        case .deletePlace: return "선택한 장소를 삭제할까요?"
        case .deleteCourse: return "선택한 코스를 삭제할까요?"
        case .changesNotSaved: return "변경 사항을 저장하지 않고\n나가시겠어요?"
        case .photoPermissionDenied: return "앱에서 사진을 사용하려면 권한을 허용해주세요."
        case .logout: return "로그아웃하시겠습니까?"
        case .withdraw: return "탈퇴하시겠습니까?"
        case .authenticationRequired: return "로그인이 필요한 기능이에요."
        }
    }
    
    var cancelText: String {
        return "취소"
    }
    
    var confirmText: String {
        switch self {
        case .deletePlace, .deleteCourse:
            return "삭제"
        case .changesNotSaved:
            return "나가기"
        case .photoPermissionDenied:
            return "설정으로 이동"
        case .logout:
            return "로그아웃"
        case .withdraw:
            return "탈퇴"
        case .authenticationRequired:
            return "로그인"
        }
    }
}
