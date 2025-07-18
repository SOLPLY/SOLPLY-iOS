//
//  NicknameView.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

import SwiftUI

struct NicknameView: View {
    
    @ObservedObject var store: OnboardingStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("솔플리와 함께할 준비 되셨나요?\n닉네임을 알려주세요.")
                .applySolplyFont(.display_20_sb)
                .foregroundStyle(.gray900)
                .padding(.top, 24.adjustedHeight)
                .padding(.bottom, 28.adjustedHeight)
            
            NicknameTextField(
                state: store.state.nicknameType,
                onChange: { text in
                    store.dispatch(.updateNickname(text))
                },
                onSubmit: { text in
                    store.dispatch(.checkNickname(text))
                }
            )
            .padding(.bottom, 24.adjustedHeight)
            
            Spacer()
            
            CTAMainButton(
                title: "다음",
                isEnabled: store.state.nicknameType == .valid
            ) {
                store.dispatch(.next)
            }
            .frame(width: 335.adjustedWidth)
        }
        .padding(.bottom, 20.adjustedHeight)
    }
}
