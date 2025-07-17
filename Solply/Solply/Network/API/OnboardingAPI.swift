//
//  OnboardingAPI.swift
//  Solply
//
//  Created by 선영주 on 7/17/25.
//

import Foundation

protocol OnboardingAPI {
    
    func fetchPersonaList() async throws -> BaseResponseBody<OnboardingResponseDTO>
    
    func fetchOnboardingCompleteInfo() async throws -> BaseResponseBody<OnboardingResponseDTO>
    
    func completeOnboarding(
        request: OnboardingRequestDTO
    ) async throws -> BaseResponseBody<EmptyResponseDTO>
}
