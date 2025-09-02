//
//  OnboardingReducer.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

enum OnboardingReducer {
    static func reduce(state: inout OnboardingState, action: OnboardingAction) {
        switch action {
        case .next:
            state.step = OnboardingStep(rawValue: state.step.rawValue + 1) ?? .onboardingComplete
            
        case .goBack:
            state.step = OnboardingStep(rawValue: state.step.rawValue - 1) ?? .townOption
            
        case .skip:
            state.step = .onboardingComplete
            
        case .selectTown(let town):
            state.selectedTown = town
            
        case .selectPersona(let persona):
            state.selectedPersona = persona
            
        case .updateNickname(let nickname):
            state.nickname = nickname

        case .updateNicknameText(let text):
            state.nickname = text
            
        case .textFieldFullFilled(let isFullfilled):
            state.isTextFieldFullFilled = isFullfilled
            
        case .onboardingCompleteOnAppear, .isLottieFinished:
            state.isOnboardingFinished = true
            
        case .nicknameChecked(let stateType):
            state.nicknameType = stateType
            
        case .fetchTown:
            state.selectedTown = nil
            state.errorMessage = nil
            
        case .fetchTownSuccess(let selectedTown, let townList):
            state.selectedTown = selectedTown
            state.townList = townList
            
        case .fetchTownFailure(let message):
            print("❌ 동네 조회 실패: \(message)")
            
        case .fetchPersona:
            state.errorMessage = nil
            
        case .fetchPersonaSuccess(let personaList):
            state.personaList = personaList
            
        case .fetchPersonaFailure(let message):
            print("❌ 페르소나 조회 실패: \(message)")
            state.errorMessage = message
            
        case .checkNickname(_):
            break
            
        case .checkNicknameSuccess(let isDuplicated):
            state.nicknameType = isDuplicated ? .duplicate : .valid
            
        case .checkNicknameFailure(let message):
            print("❌ 닉네임 중복검사 실패: \(message)")
            state.nicknameType = .duplicate
        
        case .completeOnboardingRequest:
            print("🔄 온보딩 요청 시작")

        case .completeOnboardingSuccess:
            print("✅ 온보딩 완료 성공")

        case .completeOnboardingFailure(let message):
            print("❌ 온보딩 완료 실패: \(message)")
        }
    }
}
