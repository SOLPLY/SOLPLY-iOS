//
//  OnboardingView.swift
//  Solply
//
//  Created by 김승원 on 6/29/25.
//

import SwiftUI

struct OnboardingView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store: OnboardingStore = OnboardingStore()
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            ProgressBar(step: store.state.step)
            
            switch store.state.step {
            case .townOption:
                TownOptionView(store: store)
            case .personaOption:
                PersonaOptionView(store: store)
            case .nickName:
                NicknameView(store: store)
                    .environmentObject(appCoordinator)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .customNavigationBar(.onboarding(backAction: {
            switch store.state.step {
            case .townOption:
                appCoordinator.changeRoot(to: .auth)
            case .personaOption:
                store.dispatch(.goBack)
            case .nickName:
                store.dispatch(.goBack)
            }
        }))
        .background(.gray100)
    }
}
        


#Preview {
    OnboardingView()
        .environmentObject(AppCoordinator())
}

