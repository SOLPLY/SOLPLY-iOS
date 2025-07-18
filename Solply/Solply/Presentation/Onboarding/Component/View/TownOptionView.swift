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
                ForEach(store.state.townList, id: \.self) { town in
                    TownOptionButton(
                        title: town.name,
                        isSelected: store.state.selectedTown == town
                    ) {
                        print("✅ 선택한 동네: \(town.name)")
                        withAnimation(nil) {
                            store.dispatch(.selectTown(town))
                        }
                    }
                }
                
                TownOptionButton(
                    title: nil,
                    isSelected: false
                ) {
                    print("➕ 추가 버튼 눌림")
                    // TODO: 추후 개발 예정
                }
            }
            .padding(.bottom, 32.adjustedHeight)

            Spacer()
            
            CTAMainButton(
                title: "다음",
                isEnabled: store.state.selectedTown != nil
            ) {
                print("➡️ 다음 버튼 눌림. 현재 선택된 동네: \(store.state.selectedTown?.name ?? "없음")")
                store.dispatch(.next)
            }
            .frame(width: 335.adjustedWidth)
                
        }
        .padding(.bottom, 20.adjustedHeight)
        .onAppear {
            store.dispatch(.fetchTown)
        }
    }
}
