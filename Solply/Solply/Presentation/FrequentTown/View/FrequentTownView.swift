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
    
    private let confirmAction: ((Town) -> Void)?
    
    init(confirmAction: ((Town) -> Void)? = nil) {
        self.confirmAction = confirmAction
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .center, spacing: 16.adjustedWidth) {
                ForEach(store.state.townList, id: \.self) { town in
                    let isSelected = store.state.selectedTown == town
                    TownOptionButton(
                        title: town.name,
                        isSelected: isSelected
                    ) {
                        store.dispatch(.selectTown(town))
                    }
                }
                
                TownOptionButton(
                    title: nil,
                    isSelected: false,
                    isPlusButton: true
                ) {
                    print("➕ 추가 버튼 눌림 (FrequentTownView)")
                }
            }
            .padding(.horizontal, 16.adjustedWidth)
            .padding(.top, 33.adjustedHeight)
            
            Spacer()
            
            CTAMainButton(
                title: "완료",
                isEnabled: store.state.selectedTown != nil
            ) {
                store.dispatch(.saveTown)
            }
            .padding(.horizontal, 16.adjustedWidth)
            .padding(.bottom, 20.adjustedHeight)
        }
        .customNavigationBar(
            .frequentTown(backAction: appCoordinator.goBack)
        )
        .onAppear {
            store.dispatch(.fetchTown)
        }
        .onChange(of: store.state.isSaving) { _, newValue in
            if newValue == false {
                print("✅ [자주 가는 동네] 저장 완료 - 루트로 이동")
                appCoordinator.goToRoot()
            }
        }
        .background(.gray100)
    }
}
