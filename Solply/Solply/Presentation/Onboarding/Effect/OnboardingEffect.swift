//
//  OnboardingEffect.swift
//  Solply
//
//  Created by 선영주 on 7/12/25.
//

import Foundation

struct OnboardingEffect {
    
    private let townService = TownService()
    private let onboardingService = OnboardingService()
    private let userService = UserService()
    
    func fetchTownList() async -> OnboardingAction {
        do {
            let response = try await townService.fetchTownList()
            
            guard let data = response.data else {
                return .fetchTownFailure("데이터가 없습니다")
            }

            let towns = data.favoriteTownList.map { $0.toEntity() }

            let selected = data.selectedTown?.toEntity() ?? towns.first

            guard let selectedTown = selected else {
                return .fetchTownFailure("동네가 없습니다")
            }

            return .fetchTownSuccess(selectedTown: selectedTown, townList: towns)
        } catch {
            return .fetchTownFailure("동네 불러오기 실패")
        }
    }
    
    func fetchPersonaList() async -> OnboardingAction {
        do {
            let response = try await onboardingService.fetchPersonaList()
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
            let response = try await userService.checkNickname(nickname)
            guard let isDuplicated = response.data?.isDuplicated else {
                return .nicknameChecked(.invalidCharacter)
            }
            return .nicknameChecked(isDuplicated ? .duplicate : .valid)
        } catch {
            return .nicknameChecked(.invalidCharacter)
        }
    }
    
    func completeOnboarding(selectedTownId: Int, favoriteTownIdList: [Int], persona: String, nickname: String) async -> OnboardingAction {
        let request = OnboardingRequestDTO(
            selectedTownId: selectedTownId,
            favoriteTownIdList: favoriteTownIdList,
            persona: persona,
            nickname: nickname
        )
        
        do {
            _ = try await onboardingService.completeOnboarding(request: request)
            print("✅ 온보딩 완료 API 성공")
            
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            
            return .isLottieFinished
        } catch {
            print("❌ 온보딩 완료 API 실패: \(error.localizedDescription)")
            return .completeOnboardingFailure(error.localizedDescription)
        }
    }
}
