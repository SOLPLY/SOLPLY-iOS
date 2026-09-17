//
//  TabItem.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import SwiftUI

/// 커스텀 탭바에 들어갈 탭 아이템입니다.
struct TabItem: View {
    
    // MARK: - Properties
    
    private let selectedTab: TabBarState
    private let tab: TabBarState
    private let width: CGFloat
    private let height: CGFloat
    private let onTap: (() -> Void)?
    
    private var buttonColor: Color {
        selectedTab == tab ? .gray900 : .green50
    }
    
    // MARK: - Initializer
    
    init(
        selectedTab: TabBarState,
        tab: TabBarState,
        width: CGFloat,
        height: CGFloat,
        onTap: (() -> Void)?
    ) {
        self.selectedTab = selectedTab
        self.tab = tab
        self.width = width
        self.height = height
        self.onTap = onTap
    }
    
    // MARK: - Body
    
    var body: some View {
        Button {
            onTap?()
        } label: {
            Image(tab.icon)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(6.adjusted)
                .foregroundColor(buttonColor)
                .animation(.easeInOut(duration: 0.4), value: selectedTab)
        }
        .buttonStyle(.plain)
    }
}
