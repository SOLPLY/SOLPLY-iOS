//
//  UserAPI.swift
//  Solply
//
//  Created by sun on 8/26/25.
//

import Foundation

protocol UserAPI {
    func fetchUserInformation() async throws
    -> BaseResponseBody<UserInformationResponseDTO>

    func fetchUserNicknameCheck(_ nickname: String) async throws
    -> BaseResponseBody<UserNicknameCheckResponseDTO>

    func fetchUserTowns() async throws
    -> BaseResponseBody<UserTownsResponseDTO>

    func updateUserTowns(_ request: UserTownsUpdateRequestDTO) async throws
    -> BaseResponseBody<UserTownsUpdateResponseDTO>

    func fetchPersonaList() async throws
    -> BaseResponseBody<UserPersonaListResponseDTO>

    func fetchPolicies() async throws
    -> BaseResponseBody<UserPoliciesResponseDTO>

    func updateOnboardingUserInfo(request: UserCompleteRequestDTO) async throws
    -> BaseResponseBody<UserCompleteResponseDTO>
}
