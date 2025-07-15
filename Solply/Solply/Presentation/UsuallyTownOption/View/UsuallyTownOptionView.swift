//
//  UsuallyTownOptionView.swift
//  Solply
//
//  Created by 선영주 on 7/15/25.
//

import SwiftUI

struct UsuallyTownOptionView: View {
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @ObservedObject var store: UsuallyTownOptionStore
    
    let initialSelectedOption: () -> TownOptionType
    let onNext: (TownOptionType) -> Void
    let onBack: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(spacing: 16.adjustedWidth) {
                ForEach(TownOptionType.allCases, id: \.self) { option in
                    TownOptionButton(
                        type: option,
                        isSelected: store.state.selectedOption == option
                    ) {
                        store.dispatch(.selectOption(option))
                    }
                }
            }
            .padding(.horizontal, 16.adjustedWidth)
            .padding(.top, 33.adjustedHeight)

            Spacer()

            CTAMainButton(
                title: "다음",
                isEnabled: true
            ) {
                onNext(store.state.selectedOption)
            }
            .padding(.horizontal, 16.adjustedWidth)
            .padding(.bottom, 33.adjustedHeight)
        }
        .onAppear {
            store.dispatch(.selectOption(initialSelectedOption()))
        }
        .customNavigationBar(.archiveList(title: "자주 가는 동네", backAction: onBack))
    }
}

#Preview {
    UsuallyTownOptionView(
        store: UsuallyTownOptionStore(initialOption: .named("망원동")),
        initialSelectedOption: { .named("망원동") },
        onNext: { selected in
            print("프리뷰: \(selected)")
        },
        onBack: {
            print("뒤로가기")
        }
    )
    .environmentObject(AppCoordinator())
}
