//
//  MyPageReducer.swift
//  Solply
//
//  Created by sun on 9/19/25.
//

import Foundation

enum MyPageReducer {
    static func reduce(state: inout MyPageState, action: MyPageAction) {
        switch action {
        case .editProfileTapped:
            // TODO: Coordinator 통해 프로필 수정 화면 이동
            break

        case .customerCenterTapped:
            // TODO: 고객센터 화면/외부 링크 이동
            break

        case .logoutTapped:
            // TODO: 로그아웃 처리 + 로그인 화면 이동
            break

        case .deleteAccountTapped:
            // TODO: 탈퇴 처리 + 앱 상태 초기화
            break
        }
    }
}
