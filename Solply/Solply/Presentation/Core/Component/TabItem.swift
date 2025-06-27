//
//  TabItem.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import SwiftUI

struct TabItem: View {
    
    // MARK: - Properties
    
    @Binding private var selectedTab: TabBarState
    private let tab: TabBarState
    private let width: CGFloat
    private let height: CGFloat
    private let onTap: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        selectedTab: Binding<TabBarState>,
        tab: TabBarState,
        width: CGFloat,
        height: CGFloat,
        onTap: (() -> Void)?
    ) {
        self._selectedTab = selectedTab
        self.tab = tab
        self.width = width
        self.height = height
        self.onTap = onTap
    }
    
    // MARK: - Body
    
    var body: some View {
        Button {
            selectedTab = tab
            onTap?()
        } label: {
            Text(tab.title)
                .frame(width: width, height: height)
                .foregroundColor(selectedTab == tab ? .black : .gray)
        }
        .buttonStyle(.plain)
    }
}
