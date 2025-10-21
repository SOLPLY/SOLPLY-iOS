//
//  OnboardingJGDView.swift
//  Solply
//
//  Created by sun on 10/6/25.
//

import SwiftUI

struct OnboardingJGDView: View {
    
    @ObservedObject var store: OnboardingStore
    @State private var isTownSheetPresented: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("반가워요!\n가장 먼저 추천 받고 싶은 동네를\n선택해주세요.")
                .applySolplyFont(.display_20_sb)
                .foregroundStyle(.gray900)
                .padding(.top, 24.adjustedHeight)
                .padding(.bottom, 28.adjustedHeight)

            HStack(spacing: 20.adjustedWidth) {
                ForEach(store.state.townList, id: \.self) { town in
                    JGDButton(
                        title: town.name,
                        isSelected: store.state.selectedTown == town
                    ) {
                        withAnimation(nil) { store.dispatch(.selectTown(town)) }
                    }
                }

                if let picked = store.state.selectedTown {
                    JGDButton(title: picked.name, isSelected: true) {
                        isTownSheetPresented = true
                    }
                } else {
                    JGDButton(title: nil, isSelected: false) {
                        isTownSheetPresented = true
                    }
                }
            }

            Spacer(minLength: 0)

            HStack {
                CTAMainButton(
                    title: "다음",
                    isEnabled: store.state.selectedTown != nil
                ) {
                    print("➡️ 다음 버튼 눌림. 현재 선택된 동네: \(store.state.selectedTown?.name ?? "없음")")
                    store.dispatch(.next)
                }
                .frame(width: 335.adjustedWidth)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.bottom, 16.adjustedHeight)
//        .onAppear { store.dispatch(.fetchTown) }
        .onAppear {
            store.dispatch(.selectTown(Town(id: 2, name: "망원동")))
        }
        .sheet(isPresented: $isTownSheetPresented) {
            JGDBottomSheet { _, subTown in
                if let subTown {
                    store.dispatch(.selectTown(subTown))
                }
                isTownSheetPresented = false
            }
            .presentationDetents([.height(615.adjustedHeight)])
            .presentationDragIndicator(.hidden)
            .interactiveDismissDisabled(false)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
