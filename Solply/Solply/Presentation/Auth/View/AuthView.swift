//
//  AuthView.swift
//  Solply
//
//  Created by 김승원 on 6/29/25.
//

import SwiftUI

struct AuthView: View {
    
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
            .onChange(of: store.state.isLoggedIn) { _, newValue in
                if newValue {
                    if store.state.isNewUser {
                        appCoordinator.changeRoot(to: .onboarding)
                    } else {
                        appCoordinator.changeRoot(to: .tabBar)
                    }
                }
            }
            
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
        .padding(.top, 108.adjustedHeight)
        .padding(.horizontal, 40.adjustedWidth)
    }
    
    private var buttons: some View {
        VStack(alignment: .center, spacing: 12.adjustedHeight) {
            SocialLoginButton(.kakao) {
                store.dispatch(.loginWithKakao)
            }

            SocialLoginButton(.apple) {
                store.dispatch(.loginWithApple)
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
