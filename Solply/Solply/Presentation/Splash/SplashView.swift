//
//  SplashView.swift
//  Solply
//
//  Created by 선영주 on 7/14/25.
//

import SwiftUI

struct SplashView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.green300
                .ignoresSafeArea()

            LottieView(jsonName: "Splash")
                .frame(width: 122.adjustedHeight, height: 122.adjustedHeight)
        }
        .onAppear {
            Task {
                await decideInitialRoute()
            }
        }
    }
}

// MARK: - Functions

extension SplashView {
    @MainActor
    private func decideInitialRoute() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        appState.updateUserSession()
        
        if TokenManager.shared.isSessionAvailable {
            await appState.fetchUserInformation()
            appCoordinator.changeRoot(to: .tabBar)
        } else {
            appCoordinator.changeRoot(to: .auth)
        }
    }
}

#Preview {
    SplashView()
}
