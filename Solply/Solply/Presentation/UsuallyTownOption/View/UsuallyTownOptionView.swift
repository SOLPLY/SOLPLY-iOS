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
    
    private let selectedTownOption: (() -> TownOptionType)?
    private let confirmAction: ((TownOptionType) -> Void)?
    
    init(
        store: UsuallyTownOptionStore,
        selectedTownOption: (() -> TownOptionType)? = nil,
        confirmAction: ((TownOptionType) -> Void)? = nil
    ) {
        self.store = store
        self.selectedTownOption = selectedTownOption
        self.confirmAction = confirmAction
    }
    
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
                guard let selected = store.state.selectedOption else { return }
                confirmAction?(selected)
            }
            .padding(.horizontal, 16.adjustedWidth)
            .padding(.bottom, 20.adjustedHeight)
        }
        .onAppear {
            if let initialOption = selectedTownOption?() {
                store.dispatch(.selectOption(initialOption))
            }
        }
        .customNavigationBar(.archiveList(title: "자주 가는 동네", backAction: appCoordinator.goBack))
    }
}

#Preview {
    let store = UsuallyTownOptionStore()
    store.dispatch(.selectOption(.named("망원동")))
    
    return UsuallyTownOptionView(
        store: store,
        selectedTownOption: { .named("망원동") },
        confirmAction: { selected in
            print("프리뷰: \(selected)")
        }
    )
    .environmentObject(AppCoordinator())
}
