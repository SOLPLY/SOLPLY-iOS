//
//  OnboardingService.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

import Moya

final class OnboardingService: BaseService<OnboardingTargetType> { }

extension OnboardingService: OnboardingAPI {
    
    func fetchPersonaList() async throws -> BaseResponseBody<OnboardingPersonaListResponseDTO> {
        return try await self.request(with: .fetchPersonaList)
    }
    
    func updateOnboardingUserInfo(request: OnboardingCompleteRequestDTO) async throws -> BaseResponseBody<OnboardingCompleteResponseDTO> {
        return try await self.request(with: .completeOnboarding(request))
    }
}
