//
//  NicknameView.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

import SwiftUI

struct NicknameView: View {
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    @ObservedObject var store: OnboardingStore
    
    @State private var nickname: String = ""
    
    init(store: OnboardingStore) {
        self.store = store
    }
    

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("솔플리와 함께할 준비 되셨나요?\n닉네임을 알려주세요.")
                .applySolplyFont(.display_20_sb)
                .foregroundStyle(.gray900)
                .padding(.top, 24.adjustedHeight)
                .padding(.bottom, 28.adjustedHeight)

            NicknameTextField(
                text: $nickname,
                state: store.state.nicknameType
            )
            .padding(.bottom, 24.adjustedHeight)
            .onChange(of: nickname) {
                store.dispatch(.updateNickname(nickname))
            }
            
            Spacer()
            
            CTAMainButton(
                title: "다음",
                isEnabled: store.state.nicknameType == .valid
            ) {
                store.dispatch(.next)
            }
        }
        .padding(.bottom, 20.adjustedHeight)
    }
}
