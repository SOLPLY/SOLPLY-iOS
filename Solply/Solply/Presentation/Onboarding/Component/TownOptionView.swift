//
//  TownOptionView.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

import SwiftUI

struct TownOptionView: View {
    
    @ObservedObject var store: OnboardingStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text("반가워요!\n가장 먼저 추천 받고 싶은 동네를\n선택해주세요.")
                .applySolplyFont(.display_20_sb)
                .foregroundStyle(.gray900)
                .padding(.top, 24.adjustedHeight)
                .padding(.bottom, 28.adjustedHeight)
            
            HStack(spacing: 20.adjustedWidth) {
                ForEach(TownOptionType.allCases, id: \.self) { type in
                    TownOptionButton(
                        type: type,
                        isSelected: store.state.townOption == type
                    ) {
                        store.dispatch(.selectTown(type))
                    }
                }
            }
            .padding(.bottom, 32.adjustedHeight)

            Spacer()
            
            CTAMainButton(title: "다음") {
                store.dispatch(.next)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.bottom, 20.adjustedHeight)
    }
}
