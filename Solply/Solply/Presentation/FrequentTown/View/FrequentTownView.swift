//
//  FrequentTownView.swift
//  Solply
//
//  Created by 선영주 on 7/15/25.
//

import SwiftUI

struct FrequentTownView: View {
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @ObservedObject var store = FrequentTownStore()
    
    private let confirmAction: ((TownOptionType) -> Void)?
    
    init(confirmAction: ((TownOptionType) -> Void)? = nil) {
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
                // TODO: - API 통신 성공 시 .. 하도록 수정
                appCoordinator.goToRoot()
            }
            .padding(.horizontal, 16.adjustedWidth)
            .padding(.bottom, 20.adjustedHeight)
        }
        .customNavigationBar(.archiveList(title: "자주 가는 동네", backAction: appCoordinator.goBack))
    }
}

#Preview {
    let store = FrequentTownStore()
    store.dispatch(.selectOption(.named("망원동")))
    
    return FrequentTownView(
        confirmAction: { selected in
            print("프리뷰: \(selected)")
        }
    )
    .environmentObject(AppCoordinator())
}
