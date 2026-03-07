//
//  AuthView.swift
//  Solply
//
//  Created by 김승원 on 6/29/25.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store: AuthStore = AuthStore()
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                logo
                
                Spacer()
                
                buttons
            }
            .background(.gray100)
            .onAppear {
                appCoordinator.switchTab(to: .place)
            }
            .onChange(of: store.state.isLoggedIn) { _, newValue in
                if newValue {
                    appState.updateUserSession()
                    
                    if store.state.isNewUser {
                        appCoordinator.changeRoot(to: .onboarding)
                    } else {
                        appCoordinator.changeRoot(to: .tabBar)
                    }
                }
            }
            .customNavigationBar(.auth(exploreAction: {
                AmplitudeManager.shared.track(.clickBrowseMode(entryMode: .guest))
                appState.setInitialExploreTown()
                appCoordinator.changeRoot(to: .tabBar)
            }))
            .ignoresSafeArea(edges: .bottom)
            
            if store.state.isLoading {
                loadingView
            }
        }
    }
}

// MARK: - Subviews

extension AuthView {
    private var loadingView: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            ProgressView()
                .scaleEffect(1.5)
                .progressViewStyle(.circular)
        }
    }
    
    private var logo: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(.logoFullVector)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40.adjustedWidth, height: 58.adjustedHeight)
            
            Image(.letteringVector)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 215.adjustedWidth)
            
            Text("혼자만의 시간을\n더 쉽게, 더 즐겁게!")
                .applySolplyFont(.display_20_sb)
                .foregroundColor(.gray800)
                .padding(.top, 8.adjustedHeight)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 54.adjustedHeight)
        .padding(.horizontal, 40.adjustedWidth)
    }
    
    private var buttons: some View {
        VStack(alignment: .center, spacing: 12.adjustedHeight) {
            SocialLoginButton(.kakao) {
                store.dispatch(.loginWithKakao)
                AmplitudeManager.shared.track(.clickLogin(loginMethod: .kakao))
            }

            SocialLoginButton(.apple) {
                store.dispatch(.loginWithApple)
                AmplitudeManager.shared.track(.clickLogin(loginMethod: .apple))
            }
        }
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.bottom, 76.adjustedHeight)
    }
}

#Preview {
    AuthView()
        .environmentObject(AppCoordinator())
}
