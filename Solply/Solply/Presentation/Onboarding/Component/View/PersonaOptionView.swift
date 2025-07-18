//
//  PersonaOptionView.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

import SwiftUI

struct PersonaOptionView: View {
    
    @ObservedObject var store: OnboardingStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            Text("혼자만의 시간,\n어떻게 보내고 싶나요?")
                .applySolplyFont(.display_20_sb)
                .foregroundStyle(.gray900)
                .padding(.top, 24.adjustedHeight)
                .padding(.bottom, 28.adjustedHeight)

            VStack(spacing: 16.adjustedHeight) {
                ForEach(store.state.personaList.dropFirst().prefix(4), id: \.self) { persona in
                    PersonaOptionButton(
                        title: persona.description,
                        isSelected: store.state.selectedPersona?.type == persona.type
                    ) {
                        print("✅ [페르소나 선택] \(persona.description)")
                        store.dispatch(.selectPersona(persona))
                    }
                }
            }
            .padding(.bottom, 32.adjustedHeight)

            Spacer()

            CTAMainButton(
                title: "다음",
                isEnabled: store.state.selectedPersona != nil
            ) {
                let selected = store.state.selectedPersona?.description ?? "없음"
                print("➡️ [다음 버튼] 눌림 - 선택된 페르소나: \(selected)")
                store.dispatch(.next)
            }
            .padding(.bottom, 20.adjustedHeight)
        }
        .onAppear {
            print("🧘 [OnAppear] PersonaOptionView 진입 -> 페르소나 리스트 요청")
            store.dispatch(.fetchPersona)
        }
    }
}
