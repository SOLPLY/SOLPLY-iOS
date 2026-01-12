//
//  AppState.swift
//  Solply
//
//  Created by 김승원 on 10/29/25.
//

import Foundation

final class AppState: ObservableObject {
    @Published private(set) var userSession: UserSession = .explore
    @Published var townId: Int = 2
    @Published var townName: String = "망원"
}

// MARK: - Functions

extension AppState {
    func updateUserSession() {
        self.userSession = TokenManager.shared.isSessionAvailable ? .authenticated : .explore
    }
}
