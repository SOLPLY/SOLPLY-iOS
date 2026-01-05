//
//  OnboardingEffect.swift
//  Solply
//
//  Created by 선영주 on 7/12/25.
//

import Foundation

struct OnboardingEffect {
    
    private let userService: UserAPI
    
    init(
        userService: UserAPI
    ) {
        self.userService = userService
    }
    
    func fetchPolicies() async -> OnboardingAction {
        do {
            let response = try await userService.fetchPolicies()

            guard let data = response.data else {
                return .fetchPoliciesFailure("데이터가 없습니다.")
            }

            let policies: [Policy] = data.userPolicies.map { $0.toEntity() }
            return .fetchPoliciesSuccess(policies)
        } catch {
            return .fetchPoliciesFailure("약관 정보를 가져오는데 실패했습니다.")
        }
    }
    
    func fetchPersonaList() async -> OnboardingAction {
        do {
            let response = try await userService.fetchPersonaList()
            guard let data = response.data else {
                return .fetchPersonaFailure("데이터가 없습니다")
            }
            let personas = data.personaList.map { $0.toEntity() }
            return .fetchPersonaSuccess(personas)
        } catch {
            return .fetchPersonaFailure("페르소나 리스트를 가져오는데 실패했습니다.")
        }
    }
    
    func checkNickname(_ nickname: String) async -> OnboardingAction {
        do {
            let response = try await userService.fetchUserNicknameCheck(nickname)
            guard let isDuplicated = response.data?.isDuplicated else {
                return .nicknameChecked(.invalidCharacter)
            }
            return .nicknameChecked(isDuplicated ? .duplicate : .valid)
        } catch {
            return .nicknameChecked(.invalidCharacter)
        }
    }
    
    func completeOnboarding(persona: String, nickname: String, policyAgreementInfos: [PolicyAgreementInfo]) async -> OnboardingAction {
        let request = UserCompleteRequestDTO(
            persona: persona,
            nickname: nickname,
            policyAgreementInfos: policyAgreementInfos
        )
        
        do {
            _ = try await userService.updateOnboardingUserInfo(request: request)
            print("✅ 온보딩 완료 API 성공")
            
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            
            return .isLottieFinished
        } catch {
            print("❌ 온보딩 완료 API 실패: \(error.localizedDescription)")
            return .completeOnboardingFailure(error.localizedDescription)
        }
    }
}
