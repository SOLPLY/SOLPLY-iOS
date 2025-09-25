//
//  RootView.swift
//  Solply
//
//  Created by 김승원 on 6/28/25.
//

import SwiftUI

struct RootView: View {
    @StateObject private var appCoordinator = AppCoordinator()
    @StateObject private var toastManager = ToastManager()
    @StateObject private var alertManager = AlertManager()
    
    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            appCoordinator.root.build()
                .navigationDestination(for: AppDestination.self) { $0.build() }
        }
        .customAlert(alertManager: alertManager)
        .customToast(toastManager: toastManager)
        .environmentObject(alertManager)
        .environmentObject(toastManager)
        .environmentObject(appCoordinator)
        .animation(.easeInOut(duration: 0.2), value: appCoordinator.root)
    }
}

#Preview {
    RootView()
}
