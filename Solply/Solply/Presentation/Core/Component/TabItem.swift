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
    
    // MARK: - Initializer
    
    init(selectedTab: Binding<TabBarState>, tab: TabBarState, width: CGFloat, height: CGFloat) {
        self._selectedTab = selectedTab
        self.tab = tab
        self.width = width
        self.height = height
    }
    
    // MARK: - Body
    
    var body: some View {
        Button {
            selectedTab = tab
        } label: {
            Text(tab.title)
                .frame(width: 81.adjustedWidth, height: 42.adjustedHeight)
                .foregroundColor(selectedTab == tab ? .black : .gray)
        }
        .buttonStyle(.plain)
    }
}
