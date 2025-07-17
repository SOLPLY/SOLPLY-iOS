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
    func checkNickname(_ nickname: String) async throws -> BaseResponseBody<CheckNicknameResponseDTO> {
        return try await self.request(with: .checkNickname(nickname: nickname))
    }
}
