//
//  OnboardingState.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

struct OnboardingState {
    var step: OnboardingStep = .agreement
    
    var policyList: [Policy] = []
    var isPoliciesLoading: Bool = false
    var policyErrorMessage: String? = nil
    var policyAgreementInfos: [PolicyAgreementInfo] {
        policyList.map { PolicyAgreementInfo(policyId: $0.id, isAgree: $0.isAgreed) }
    }
    
    var personaList: [Persona] = []
    var selectedPersona: Persona? = nil
    var errorMessage: String? = nil

    var nickname: String = ""
    var nicknameType: NicknameTextFieldState = .placeholder
    var isTextFieldFullFilled: Bool = false
    
    var isLottieFinished: Bool = false
    var isOnboardingFinished: Bool = false
}
