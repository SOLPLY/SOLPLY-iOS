//
//  UserService.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

import Moya

final class UserService: BaseService<UserTargetType> { }

extension UserService {
    func fetchUserInformation() async throws -> BaseResponseBody<UserInformationResponseDTO> {
        return try await self.request(with: .fetchUserInformation)
    }
    
    func checkNickname(_ nickname: String) async throws -> BaseResponseBody<CheckNicknameResponseDTO> {
        return try await self.request(with: .checkNickname(nickname: nickname))
    }
}
