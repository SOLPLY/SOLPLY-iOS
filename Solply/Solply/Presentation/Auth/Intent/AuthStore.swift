//
//  AuthStore.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import AuthenticationServices
import Foundation

@MainActor
final class AuthStore: NSObject, ObservableObject {
    
    @Published private(set) var state = AuthState()
    private let effect = AuthEffect(service: AuthService())
    
    func dispatch(_ action: AuthAction) {
        AuthReducer.reduce(state: &state, action: action)
        
        switch action {
        case .loginWithKakao:
            Task {
                let result = await effect.login(with: .kakao)
                self.dispatch(result)
            }
            
        case .loginWithApple:
            startAppleLogin()
            
        default:
            break
        }
    }
}

// MARK: - Functions

extension AuthStore {
    private func startAppleLogin() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding

extension AuthStore: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        if let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive }),
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            return keyWindow
        }

        if let anyWindow = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first {
            return anyWindow
        }

        return ASPresentationAnchor()
    }
}

// MARK: - ASAuthorizationControllerDelegate

extension AuthStore: ASAuthorizationControllerDelegate {
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            self.dispatch(.loginFailed(.apiError(message: "애플 인증 정보를 가져오는 데 실패했습니다.")))
            return
        }
        
        guard let tokenData = credential.identityToken else {
            self.dispatch(.loginFailed(.apiError(message: "애플 로그인 토큰을 확인할 수 없습니다.")))
            return
        }
        
        guard let token = String(data: tokenData, encoding: .utf8) else {
            self.dispatch(.loginFailed(.apiError(message: "애플 인증에 실패했습니다.")))
            return
        }

        Task {
            let result = await effect.login(with: .apple, oauthAccessToken: token)
            self.dispatch(result)
        }
    }
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        if let authError = error as? ASAuthorizationError,
           authError.code == .canceled {
            self.dispatch(.loginFailed(.apiError(message: "사용자가 애플 로그인을 취수했습니다.")))
            return
        }
    }
}

