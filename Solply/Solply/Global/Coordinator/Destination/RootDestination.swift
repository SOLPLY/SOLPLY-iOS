//
//  RootDestination.swift
//  Solply
//
//  Created by 김승원 on 6/28/25.
//

import SwiftUI

enum RootDestination: Hashable {
    case splash
    case auth
    case onboarding
    case tabBar
    case myPage
}

extension RootDestination {
    @ViewBuilder
    func build() -> some View {
        switch self {
        case .splash:
            SplashView()
        case .auth:
            AuthView()
        case .onboarding:
            OnboardingView()
        case .tabBar:
            TabBarView()
        case .myPage:
            MyPageView()
        }
    }
}
