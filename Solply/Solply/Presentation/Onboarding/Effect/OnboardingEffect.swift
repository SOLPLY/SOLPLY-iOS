//
//  OnboardingEffect.swift
//  Solply
//
//  Created by 선영주 on 7/12/25.
//

import Foundation

struct OnboardingEffect {
    
    private let townService: TownAPI
    private let userService: UserAPI
    
    init(
        townService: TownAPI,
        userService: UserAPI
    ) {
        self.townService = townService
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
    
    
    func fetchTowns() async -> OnboardingAction {
        do {
            let response = try await townService.fetchTownList()
            
            guard let data = response.data else {
                return .fetchTownsFailure("데이터가 없습니다.")
            }
            
            let towns = data.toEntity()
            
            return .fetchTownsSuccess(townList: towns)
        } catch {
            return .fetchTownsFailure("동네 불러오기 실패")
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
    
    func completeOnboarding(selectedTownId: Int, persona: String, nickname: String, policyAgreementInfos: [PolicyAgreementInfo]) async -> OnboardingAction {
        let request = UserCompleteRequestDTO(
            selectedTownId: selectedTownId,
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
