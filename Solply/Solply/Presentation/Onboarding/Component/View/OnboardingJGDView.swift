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
                if let selectedTown = store.state.selectedTown {
                    ForEach(selectedTown.subTowns, id: \.id) { subTown in
                        JGDButton(
                            title: subTown.townName,
                            isSelected: store.state.selectedSubTown == subTown
                        ) {
                            store.dispatch(.selectSubTown(subTown))
                        }
                    }
                } else {
                    JGDButton(
                        title: store.state.selectedSubTown?.townName,
                        isSelected: store.state.selectedSubTown != nil
                    ) {
                        isTownSheetPresented = true
                    }
                }
            }
            
            Spacer(minLength: 0)
            
            HStack {
                SolplyMainButton(
                    title: "다음",
                    isEnabled: store.state.selectedSubTown != nil
                ) {
                    print("➡️ 다음 버튼 눌림. 현재 선택된 동네: \(store.state.selectedSubTown?.townName ?? "없음")")
                    store.dispatch(.next)
                }
                .frame(width: 335.adjustedWidth)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.bottom, 20.adjustedHeight)
        .onAppear { store.dispatch(.fetchTowns) }
        .sheet(isPresented: $isTownSheetPresented) {
            JGDBottomSheet { town, subTown in
                if let subTown {
                    store.dispatch(.selectSubTown(subTown))
                }
                isTownSheetPresented = false
            }
            .presentationDetents([PresentationDetent.fraction(0.85)])
            .presentationDragIndicator(.hidden)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
