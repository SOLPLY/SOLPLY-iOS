//
//  AppState.swift
//  Solply
//
//  Created by 김승원 on 10/29/25.
//

import Foundation

final class AppState: ObservableObject {
    @Published private(set) var userSession: UserSession = .explore
    @Published var townId: Int = 0
    @Published var townName: String = ""
    
    @Published private(set) var userInformation: UserInformation? = nil
    @Published private(set) var isUserInformationLoading: Bool = true
    
    private let userService = UserService()
    
    private let exploreTitle: String = "로그인하고\n취향에 맞는 추천을 받아보세요"
    var placeRecommendTitle: String {
        switch userSession {
        case .explore:
            return exploreTitle
            
        case .authenticated:
            guard let userInformation else { return "" }
            
            return "\(userInformation.persona.description)\n\(userInformation.nickname)님을 위한 오늘의 추천"
        }
    }
    
    var courseRecommendTitle: String {
        switch userSession {
        case .explore:
            return exploreTitle
        case .authenticated:
            guard let userInformation else { return "" }
            
            return "\(userInformation.persona.description)\n\(userInformation.nickname)님을 위한 오늘의 코스"
        }
    }
}

// MARK: - Functions

extension AppState {
    func fetchUserInformation() async {
        guard userSession == .authenticated else { return }
        
        await MainActor.run { isUserInformationLoading = true }
        
        do {
            let response = try await userService.fetchUserInformation()
            
            guard let data = response.data else {
                await MainActor.run { isUserInformationLoading = false }
                return
            }
            
            let information = UserInformation(dto: data)
            await MainActor.run {
                self.userInformation = information
                self.townName = information.townName
                self.townId = information.townId
                self.isUserInformationLoading = false
            }
        } catch {
            await MainActor.run { isUserInformationLoading = false }
        }
    }
    
    func updateUserSession() {
        self.userSession = TokenManager.shared.isSessionAvailable ? .authenticated : .explore
    }
    
    func setInitialExploreTown() {
        self.townId = 2
        self.townName = "망원"
    }

    func requireLoginWithAlert(onAuthenticated: (() -> Void)? = nil, onExplore: (() -> Void)? = nil) {
        guard userSession == .authenticated else {
            AlertManager.shared.showAlert(alertType: .authenticationRequired, onCancel: nil) {
                onExplore?()
            }
            return
        }
        onAuthenticated?()
    }
}
