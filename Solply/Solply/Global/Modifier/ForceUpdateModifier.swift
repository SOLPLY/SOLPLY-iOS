//
//  ForceUpdateModifier.swift
//  Solply
//
//  Created by 김승원 on 4/5/26.
//

import SwiftUI

struct ForceUpdateModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Bindable var monitor: AppVersionMonitor
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .alert("업데이트 알림", isPresented: $monitor.isUpdateRequired) {
                Button("업데이트") {
                    openAppStore()
                }
                .buttonStyle(.plain)
            } message: {
                Text("더 나은 서비스를 위해 최신 버전으로 업데이트해 주세요.")
            }
    }
}

// MARK: - Functions

extension ForceUpdateModifier {
    private func openAppStore() {
        guard let url = AppEnvironment.appStoreURL else { return }
        UIApplication.shared.open(url)
    }
}

extension View {
    func forceUpdateAlert(monitor: AppVersionMonitor) -> some View {
        modifier(ForceUpdateModifier(monitor: monitor))
    }
}
