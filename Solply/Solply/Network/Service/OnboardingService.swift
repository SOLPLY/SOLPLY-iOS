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
    
    func fetchPersonaList() async throws -> BaseResponseBody<OnboardingResponseDTO> {
        return try await self.request(with: .fetchPersonaList)
    }
    
    func fetchOnboardingCompleteInfo() async throws -> BaseResponseBody<OnboardingResponseDTO> {
        return try await self.request(with: .fetchOnboardingCompleteInfo)
    }
    
    func completeOnboarding(request: OnboardingRequestDTO) async throws -> BaseResponseBody<EmptyResponseDTO> {
        return try await self.request(with: .completeOnboarding(request))
    }
}
