//
//  SolplyTabBar.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import SwiftUI

/// 장소, 코스 탭을 전환하는 커스텀 탭바입니다.
/// TabBarState 바인딩을 통해 선택된 탭(뷰)을 교체합니다.
struct SolplyTabBar: View {
    
    // MARK: - Properties
    
    @Binding private var selectedTab: TabBarState
    @State private var capsuleOffsetX: CGFloat = 0
    @State private var isDragging: Bool = false
    @State private var dragStartOffset: CGFloat = 0
    private let tabItemCapsuleWidth: CGFloat = 72.adjustedWidth
    private let tabItemCapsuleHeight: CGFloat = 48.adjustedHeight
    
    // MARK: - Initializer
    
    init(selectedTab: Binding<TabBarState>) {
        self._selectedTab = selectedTab
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .leading) {
            tabCapsule
            
            tabButton
        }
        .padding(.horizontal, 6.adjustedWidth)
        .padding(.vertical, 6.adjustedHeight)
        .background(.gray900)
        .capsuleClipped()
    }
}

// MARK: - Subviews

extension SolplyTabBar {
    private var tabCapsule: some View {
        Capsule()
            .fill(.green100)
            .frame(width: tabItemCapsuleWidth, height: tabItemCapsuleHeight)
            .offset(x: capsuleOffsetX)
            .animation(.easeInOut(duration: 0.2), value: capsuleOffsetX)
    }
    
    private var tabButton: some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(TabBarState.allCases, id: \.self) { tab in
                TabItem(
                    selectedTab: selectedTab,
                    tab: tab,
                    width: tabItemCapsuleWidth,
                    height: tabItemCapsuleHeight
                ) {
                    selectTab(tab)
                }
            }
        }
        .highPriorityGesture(
            DragGesture(minimumDistance: 5)
                .onChanged { value in
                    if !isDragging {
                        isDragging = true
                        dragStartOffset = capsuleOffsetX
                    }
                    
                    let newOffset = dragStartOffset + value.translation.width.adjustedWidth
                    let maxOffset = CGFloat(TabBarState.allCases.count - 1) * tabItemCapsuleWidth
                    let clampedOffset = max(0, min(maxOffset, newOffset))
                    
                    capsuleOffsetX = clampedOffset
                    
                    let switchTabOffset = tabItemCapsuleWidth / 2
                    
                    if clampedOffset > switchTabOffset && selectedTab == .place {
                        selectedTab = .course
                    } else if clampedOffset < switchTabOffset && selectedTab == .course {
                        selectedTab = .place
                    }
                }
                .onEnded { value in
                    isDragging = false
                    capsuleOffsetX = calculateCapsuleOffsetX(for: selectedTab)
                }
        )
    }
}

// MARK: - Functions

extension SolplyTabBar {
    private func selectTab(_ selectedTab: TabBarState) {
        self.selectedTab = selectedTab
        capsuleOffsetX = calculateCapsuleOffsetX(for: selectedTab)
    }
    
    private func calculateCapsuleOffsetX(for tab: TabBarState) -> CGFloat {
        let index = TabBarState.allCases.firstIndex(of: tab) ?? 0
        return CGFloat(index) * tabItemCapsuleWidth
    }
}
