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
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @Binding private var selectedTab: TabBarState
    @State private var capsuleOffsetX: CGFloat = 0
    @State private var isDragging: Bool = false
    @State private var dragStartOffset: CGFloat = 0
    
    private let tabIconWidth: CGFloat = 36.adjusted
    private let tabIconHeight: CGFloat = 36.adjusted
    private let tabItemCapsuleWidth: CGFloat = 48.adjusted
    private let tabItemCapsuleHeight: CGFloat = 48.adjusted
    
    // TODO: - 1차 스프린트 이후 클로저 프로퍼티 삭제
    private let bookmarkAction: (() -> Void)?
    private let myPageAction: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        selectedTab: Binding<TabBarState>,
        bookmarkAction: (() -> Void)? = nil,
        myPageAction: (() -> Void)? = nil
    ) {
        self._selectedTab = selectedTab
        self.bookmarkAction = bookmarkAction
        self.myPageAction = myPageAction
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .leading) {
            tabCapsule
            
            tabButton
        }
        .padding(.horizontal, 8.adjusted)
        .padding(.vertical, 6.adjusted)
        .background(.gray900)
        .capsuleClipped()
        .onChange(of: selectedTab) {
            capsuleOffsetX = calculateCapsuleOffsetX(for: selectedTab)
        }
    }
}

// MARK: - Subviews

extension SolplyTabBar {
    private var tabCapsule: some View {
        Capsule()
            .fill(.green200)
            .frame(width: tabItemCapsuleWidth, height: tabItemCapsuleHeight)
            .offset(x: capsuleOffsetX)
            .animation(.easeInOut(duration: 0.2), value: capsuleOffsetX)
    }
    
    private var tabButton: some View {
        HStack(alignment: .center, spacing: 16.adjustedWidth) {
            ForEach(TabBarState.allCases, id: \.self) { tab in
                TabItem(
                    selectedTab: selectedTab,
                    tab: tab,
                    width: tabIconWidth,
                    height: tabIconHeight
                ) {
                    // TODO: - 1차 스프린트 이후 분기처리 삭제
                    switch tab {
                    case .place, .course: selectTab(tab)
                    case .bookmark: bookmarkAction?()
                    case .myPage: myPageAction?()
                    }
                    
                    // selectTab(tab)
                }
            }
        }
        .padding(.horizontal, 6.adjustedWidth)
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
        return CGFloat(index) * (tabItemCapsuleWidth + 4.adjustedWidth)
    }
}
