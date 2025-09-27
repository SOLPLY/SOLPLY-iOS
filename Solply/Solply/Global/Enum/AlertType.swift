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
    case leaveCourseDetail
    case photoPermissionDenied
    
    var title: String {
        switch self {
        case .deletePlace: return "선택한 장소를 삭제할까요?"
        case .deleteCourse: return "선택한 코스를 삭제할까요?"
        case .leaveCourseDetail: return "변경 사항을 저장하지 않고\n나가시겠어요?"
        case .photoPermissionDenied: return "앱에서 사진을 사용하려면 권한을 허용해주세요"
        }
    }
    
    var cancelText: String {
        switch self {
        case .deletePlace, .deleteCourse, .leaveCourseDetail, .photoPermissionDenied:
            return "취소"
        }
    }
    
    var confirmText: String {
        switch self {
        case .deletePlace, .deleteCourse:
            return "삭제"
        case .leaveCourseDetail:
            return "나가기"
        case .photoPermissionDenied:
            return "설정으로 이동"
        }
    }
}
