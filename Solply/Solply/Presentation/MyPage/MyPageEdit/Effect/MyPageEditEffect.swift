//
//  MyPageEditEffect.swift
//  Solply
//
//  Created by 김승원 on 11/12/25.
//

import Foundation

struct MyPageEditEffect {
    private let userService: UserAPI
    
    init(userService: UserAPI) {
        self.userService = userService
    }
}

// MARK: - UserAPI

extension MyPageEditEffect {
    func fetchUserNicknameCheck(nickname: String) async -> MyPageEditAction {
        do {
            let response = try await userService.fetchUserNicknameCheck(nickname)
            
            guard let data = response.data else {
                return .fetchUserNicknameCheckFailed(error: .responseError)
            }
            
            return .fetchUserNicknameCheckSuccess(isDuplicated: data.isDuplicated)
        } catch let error as NetworkError {
            return .fetchUserNicknameCheckFailed(error: error)
        } catch {
            return .fetchUserNicknameCheckFailed(error: .unknownError)
        }
    }
}
