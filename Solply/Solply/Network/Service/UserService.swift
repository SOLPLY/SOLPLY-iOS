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
    
    func fetchPolicies() async throws -> BaseResponseBody<UserPoliciesResponseDTO> {
            try await self.request(with: .fetchPolicies)
        }
    
    func fetchUserInformation() async throws -> BaseResponseBody<UserInformationResponseDTO> {
        return try await self.request(with: .fetchUserInformation)
    }
    
    func fetchRegisteredPlaces(userId: Int, page: Int, size: Int) async throws -> BaseResponseBody<UserRegisteredPlacesResponseDTO> {
        return try await self.request(with: .fetchRegisteredPlaces(userId: userId, page: page, size: size))
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
    func fetchPersonaList() async throws -> BaseResponseBody<UserPersonaListResponseDTO> {
        return try await self.request(with: .fetchPersonaList)
    }
    
    func updateOnboardingUserInfo(request: UserCompleteRequestDTO) async throws -> BaseResponseBody<UserCompleteResponseDTO> {
        return try await self.request(with: .completeOnboarding(request))
    }
    
    func updateUserInformation(
        request: UpdateUserInformationRequestDTO
    ) async throws -> BaseResponseBody<UpdateUserInformationResponseDTO> {
        return try await self.request(with: .updateUserInformation(request: request))
    }
}
