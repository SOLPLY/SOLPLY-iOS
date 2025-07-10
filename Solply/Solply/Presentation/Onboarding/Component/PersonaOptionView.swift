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
                ForEach(PersonaType.allCases, id: \.self) { persona in
                    PersonaOptionButton(
                        title: persona.personaString,
                        isSelected: store.state.personaOption == persona
                    ) {
                        store.dispatch(.selectPersona(persona))
                    }
                }
            }
            .padding(.bottom, 32.adjustedHeight)

            Spacer()

            HStack(spacing: 12.adjustedWidth) {
                CTASubButton(title: "건너뛰기", type: .clear) {
                    store.dispatch(.skip)
                }
                .frame(width: 90.adjustedWidth)

                CTAMainButton(title: "다음") {
                    store.dispatch(.next)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.bottom, 20.adjustedHeight)
        }
        .background(Color.gray100)
    }
}
