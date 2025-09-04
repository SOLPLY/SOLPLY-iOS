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
        VStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 0) {
                Image(.logoFullVector)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40.adjustedHeight, height: 58.adjustedHeight)
                
                Image(.letteringVector)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 215.adjustedHeight)
                
                Text("혼자만의 시간을\n더 쉽게, 더 즐겁게!")
                    .applySolplyFont(.display_20_sb)
                    .foregroundColor(.gray800)
                    .padding(.top, 8.adjustedHeight)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 108.adjustedHeight)
            .padding(.horizontal, 40.adjustedHeight)
            
            Spacer()
            
            Button {
                store.dispatch(.login(.kakao))
            } label: {
                HStack(alignment: .center, spacing: 12) {
                    Image(.kakaoTalkIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28.adjustedHeight, height: 28.adjustedHeight)
                    
                    Text("카카오로 시작하기")
                        .applySolplyFont(.button_16_m)
                        .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                }
                .padding(.horizontal, 16.adjustedHeight)
                .padding(.vertical, 12.adjustedHeight)
                .buttonStyle(.plain)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 1, green: 0.9, blue: 0))
                .cornerRadius(12)
                .padding(.horizontal, 24.adjustedHeight)
            }
            .buttonStyle(.plain)
            
            Button {
                store.dispatch(.login(.apple))
            } label: {
                HStack(alignment: .center, spacing: 12) {
                    Image(.appleLogo)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28.adjustedHeight, height: 28.adjustedHeight)
                    
                    Text("Apple로 시작하기")
                        .applySolplyFont(.button_16_m)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 16.adjustedHeight)
                .padding(.vertical, 12.adjustedHeight)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.black)
                .cornerRadius(12)
                .padding(.horizontal, 24.adjustedHeight)
                .padding(.top, 12.adjustedHeight)
                .padding(.bottom, 76.adjustedHeight)
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
    }
}

#Preview {
    AuthView()
        .environmentObject(AppCoordinator())
}
