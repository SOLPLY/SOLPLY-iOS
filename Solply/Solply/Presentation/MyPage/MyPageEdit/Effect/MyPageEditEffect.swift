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
    
    func updateUserInformation(request: UpdateUserInformationRequestDTO) async -> MyPageEditAction {
        do {
            let response = try await userService.updateUserInformation(request: request)
            
            guard let data = response.data else {
                return .updateUserInformationFailed(error: .responseError)
            }
            
            return .updateUserInformationSuccess
        } catch let error as NetworkError {
            return .updateUserInformationFailed(error: error)
        } catch {
            return .updateUserInformationFailed(error: .unknownError)
        }
    }
}
