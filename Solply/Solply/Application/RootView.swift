//
//  RootView.swift
//  Solply
//
//  Created by 김승원 on 6/28/25.
//

import SwiftUI

struct RootView: View {
    @StateObject private var appCoordinator = AppCoordinator()
    
    var body: some View {
        Group {
            switch appCoordinator.root {
            case .auth:
                AuthView()
            case .onboarding:
                OnboardingView()
            case .tabBar:
                TabBarView()
            }
        }
        .environmentObject(appCoordinator)
        .animation(.easeInOut(duration: 0.2), value: appCoordinator.root)
    }
}

#Preview {
    RootView()
}
