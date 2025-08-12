//
//  TownOptionView.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

import SwiftUI

struct TownOptionView: View {
    @ObservedObject var store: OnboardingStore

    private let hSpacing: CGFloat = 20.adjustedWidth
    private let vSpacing: CGFloat = 32.adjustedHeight
    private let desiredSlots = 3

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("반가워요!\n가장 먼저 추천 받고 싶은 동네를\n선택해주세요.")
                .applySolplyFont(.display_20_sb)
                .foregroundStyle(.gray900)
                .padding(.top, 24.adjustedHeight)
                .padding(.bottom, 28.adjustedHeight)

            GeometryReader { proxy in
                let avail = proxy.size.width
                let itemSize = floor((avail - hSpacing * CGFloat(desiredSlots - 1)) / CGFloat(desiredSlots))
                let towns = Array(store.state.townList.prefix(desiredSlots - 1))

                HStack(spacing: hSpacing) {
                    ForEach(0..<desiredSlots, id: \.self) { idx in
                        if idx < towns.count {
                            let town = towns[idx]
                            TownOptionButton(
                                title: town.name,
                                isSelected: store.state.selectedTown == town
                            ) {
                                print("✅ 선택한 동네: \(town.name)")
                                withAnimation(nil) {
                                    store.dispatch(.selectTown(town))
                                }
                            }
                            .frame(width: itemSize, height: itemSize)
                        } else if idx == towns.count {
                            TownOptionButton(title: nil, isSelected: false) {
                                print("➕ 추가 버튼 눌림")
                            }
                            .frame(width: itemSize, height: itemSize)
                        } else {
                            Color.clear.frame(width: itemSize, height: itemSize)
                        }
                    }
                }
                .padding(.bottom, vSpacing)
                .animation(nil, value: store.state.townList)
                .transaction { $0.animation = nil }
            }
            .frame(height: 120.adjustedHeight)

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
        .padding(.bottom, 20.adjustedHeight)
        .onAppear {
            store.dispatch(.fetchTown)
        }
    }
}
