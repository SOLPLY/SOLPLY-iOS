//
//  RootView.swift
//  Solply
//
//  Created by 김승원 on 6/28/25.
//

import SwiftUI

struct RootView: View {
    
    // MARK: - Properties
    
    @StateObject private var appState = AppState()
    @StateObject private var appCoordinator = AppCoordinator()
    @StateObject private var toastManager = ToastManager()
    @StateObject private var alertManager = AlertManager()
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            appCoordinator.root.build()
                .navigationDestination(for: AppDestination.self) { $0.build() }
        }
        .customAlert(alertManager: alertManager)
        .customToast(toastManager: toastManager)
        .environmentObject(appState)
        .environmentObject(alertManager)
        .environmentObject(toastManager)
        .environmentObject(appCoordinator)
        .animation(.easeInOut(duration: 0.2), value: appCoordinator.root)
        .onReceive(NotificationCenter.default.publisher(for: .tokenExpired)) { _ in
            appState.updateUserSession()
            appCoordinator.changeRoot(to: .auth)
            toastManager.showToast(
                content: ToastContent(
                    toastType: .defaultToast,
                    message: "세션이 만료되었습니다. 다시 로그인해주세요.",
                    bottomPadding: 16.adjustedHeight
                )
            )
        }
    }
}

#Preview {
    RootView()
}
