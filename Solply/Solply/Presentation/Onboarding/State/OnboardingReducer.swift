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
            state.step = OnboardingStep(rawValue: state.step.rawValue - 1) ?? .onboardingJGD
            
        case .skip:
            state.step = .onboardingComplete
            
        case .selectTown(let town):
            state.selectedTown = town
            state.selectedSubTown = town.subTowns.first
        
        case .selectSubTown(let subTown):
            state.selectedSubTown = subTown
            
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
            
        case .fetchTowns:
            state.errorMessage = nil
            
        case .fetchTownsSuccess(let townList):
            state.townList = townList

            state.selectedTown = nil
            state.selectedSubTown = nil

        case .fetchTownsFailure(let message):
            state.errorMessage = message
            
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
