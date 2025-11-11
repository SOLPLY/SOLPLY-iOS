//
//  MyPageEditReducer.swift
//  Solply
//
//  Created by sun on 9/26/25.
//

import Foundation

enum MyPageEditReducer {
    static func reduce(state: inout MyPageEditState, action: MyPageEditAction) {
        switch action {
        case .loadUserInformation:
            break
            
        case .nicknameChanged(let text):
            state.nickname = text

        case .personaSelected(let persona):
            state.selectedPersona = persona

        case .completeTapped:
            // 저장/검증/API 호출 등은 외부에서 처리
            break

        case .backTapped:
            break
        }
    }
}
