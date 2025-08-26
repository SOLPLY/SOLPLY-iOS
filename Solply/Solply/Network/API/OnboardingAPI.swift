//
//  OnboardingAPI.swift
//  Solply
//
//  Created by 선영주 on 7/17/25.
//

import Foundation

protocol OnboardingAPI {
    func fetchPersonaList() async throws -> BaseResponseBody<OnboardingPersonaListResponseDTO>
    
    func completeOnboarding(
        request: OnboardingCompleteRequestDTO
    ) async throws -> BaseResponseBody<OnboardingCompleteResponseDTO>
}
