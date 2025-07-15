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
    
    let initialTownOption: () -> TownOptionType
    let confirmAction: (TownOptionType) -> Void
    let backAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .center, spacing: 16.adjustedWidth) {
                ForEach(TownOptionType.allCases, id: \.self) { option in
                    let isSelected = store.state.selectedOption == option
                    TownOptionButton(
                        type: option,
                        isSelected: isSelected
                    ) {
                        store.dispatch(.selectOption(option))
                    }
                }
            }
            .padding(.horizontal, 16.adjustedWidth)
            .padding(.top, 33.adjustedHeight)

            Spacer()

            CTAMainButton(
                title: "완료",
                isEnabled: true
            ) {
                guard let selected = store.state.selectedOption else {
                    return
                }
                confirmAction(selected)
            }
            .padding(.horizontal, 16.adjustedWidth)
            .padding(.bottom, 33.adjustedHeight)
        }
        .onAppear {
            store.dispatch(.selectOption(initialTownOption()))
        }
        .customNavigationBar(.archiveList(title: "자주 가는 동네", backAction: backAction))
        }
    }

#Preview {
    let store = UsuallyTownOptionStore()
    store.dispatch(.selectOption(.named("망원동")))

    return UsuallyTownOptionView(
        store: store,
        initialTownOption: { .named("망원동") },
        confirmAction: { selected in
            print("프리뷰: \(selected)")
        },
        backAction: {
            print("뒤로가기")
        }
    )
    .environmentObject(AppCoordinator())
}
