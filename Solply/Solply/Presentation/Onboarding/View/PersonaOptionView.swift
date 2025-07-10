//
//  PersonaOptionView.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

import SwiftUI

struct PersonaOptionView: View {
    
    @ObservedObject var store: OnboardingStore
    @State private var selectedIndex: Int? = nil
    
    private let personas = [
        "조용한 공간에 오래 머물고 싶어요",
        "이곳저곳 둘러보고 싶어요",
        "취향이 담긴 곳을 찾고 싶어요",
        "자연을 감상하며 쉬고 싶어요"
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            Text("혼자만의 시간,\n어떻게 보내고 싶나요?")
                .applySolplyFont(.display_20_sb)
                .foregroundStyle(.gray900)
                .padding(.top, 24.adjustedHeight)
                .padding(.bottom, 28.adjustedHeight)

            VStack(spacing: 16.adjustedHeight) {
                ForEach(personas.indices, id: \.self) { index in
                    PersonaOptionButton(
                        title: personas[index],
                        isSelected: selectedIndex == index
                    ) {
                        selectedIndex = index
                        store.dispatch(.selectPersona(personas[index]))
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
            .padding(.bottom, 40.adjustedHeight)
        }
        .padding(.horizontal, 20.adjustedWidth)
        .background(Color.gray100)
    }
}
