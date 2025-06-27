//
//  SolplyTabBar.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import SwiftUI

struct SolplyTabBar: View {
    
    // MARK: - Properties
    
    @State private var selectedTab: TabBarState = .place
    private let tabItemCapsuleWidth: CGFloat = 81.adjustedWidth
    private let tabItemCapsuleHeight: CGFloat = 42.adjustedHeight
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .leading) {
            tabItemCapsule
            
            HStack(spacing: 0) {
                ForEach(TabBarState.allCases, id: \.self) { tab in
                    TabItem(
                        selectedTab: $selectedTab,
                        tab: tab,
                        width: tabItemCapsuleWidth,
                        height: tabItemCapsuleHeight
                    )
                }
            }
        }
        .padding(.horizontal, 4.adjustedWidth)
        .padding(.vertical, 4.adjustedHeight)
        .background(Color(.systemGray5))
        .capsuleClipped()
    }
}

// MARK: - Subviews

extension SolplyTabBar {
    private var tabItemCapsule: some View {
        Capsule()
            .fill(Color(.systemGray3))
            .frame(width: tabItemCapsuleWidth, height: tabItemCapsuleHeight)
            .offset(x: capsuleOffsetX(for: selectedTab))
            .animation(.easeInOut(duration: 0.2), value: selectedTab)
    }
}

// MARK: - Functions

extension SolplyTabBar {
    private func capsuleOffsetX(for tab: TabBarState) -> CGFloat {
        let index = TabBarState.allCases.firstIndex(of: tab) ?? 0
        return CGFloat(index) * tabItemCapsuleWidth
    }
}

#Preview {
    SolplyTabBar()
}
