//
//  UserService.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

import Moya

final class UserService: BaseService<UserTargetType> { }

extension UserService: UserAPI {
    
    func fetchUserInformation() async throws -> BaseResponseBody<UserInformationResponseDTO> {
        return try await self.request(with: .fetchUserInformation)
    }
    
    func fetchUserNicknameCheck(_ nickname: String) async throws -> BaseResponseBody<UserNicknameCheckResponseDTO> {
        return try await self.request(with: .checkNickname(nickname: nickname))
    }
    
    func fetchUserTowns() async throws -> BaseResponseBody<UserTownsResponseDTO> {
        return try await self.request(with: .fetchUserTowns)
    }
    
    func updateUserTowns(_ body: UserTownsUpdateRequestDTO) async throws
        -> BaseResponseBody<UserTownsUpdateResponseDTO> {
            try await self.request(with: .updateUserTowns(body))
        }
}
