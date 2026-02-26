//
//  OnboardingView.swift
//  Solply
//
//  Created by 김승원 on 6/29/25.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store: OnboardingStore = OnboardingStore()
    
    var body: some View {
        Group {
            if store.state.step != .onboardingComplete {
                VStack(alignment: .leading, spacing: 0) {
                    
                    if !store.state.isOnboardingFinished {
                        ProgressBar(step: store.state.step)
                            .animation(.easeInOut(duration: 0.3), value: store.state.step)
                    }
                    switch store.state.step {
                    case .agreement:
                        OnboardingAgreementView(store: store)
                    case .personaOption:
                        PersonaOptionView(store: store)
                    case .nickName:
                        NicknameView(store: store)
                    case .onboardingComplete:
                        OnboardingCompleteView(store: store)
                    }
                }
                .animation(.easeOut(duration: 0.2), value: store.state.step)
                .padding(.horizontal, 20.adjustedWidth)
                .onChange(of: store.state.isOnboardingFinished) { oldValue, newValue in
                    if newValue {
                        appCoordinator.changeRoot(to: .tabBar)
                    }
                }
                .customNavigationBar(.backOnly(backAction: {
                    switch store.state.step {
                    case .agreement:
                        appCoordinator.changeRoot(to: .auth)
                    case .personaOption, .nickName:
                        store.dispatch(.goBack)
                    case .onboardingComplete:
                        break
                    }
                }))
                .background(.gray100)
            } else {
                VStack(alignment: .leading, spacing: 0) {
                    OnboardingCompleteView(store: store)
                }
            }
        }
        .onTapGesture {
            hideKeyboard()
            
            if store.state.step == .nickName {
                    store.dispatch(.checkNickname(store.state.nickname))
                }
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AppCoordinator())
}
