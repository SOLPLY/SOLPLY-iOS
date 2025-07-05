//
//  TabBarView.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import SwiftUI

struct TabBarView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            tabContent
            
            tabBar
                .padding(.bottom, 16.adjustedHeight)
        }
    }
}

// MARK: - Subviews

extension TabBarView {
    private var tabContent: some View {
        Group {
            PlaceRecommendView()
                .visible(appCoordinator.selectedTab == .place)
            
            CourseRecommendView()
                .visible(appCoordinator.selectedTab == .course)
        }
        .animation(.easeInOut(duration: 0.1), value: appCoordinator.selectedTab)
    }
    
    private var tabBar: some View {
        ZStack(alignment: .center) {
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                
                ArchiveButton {
                    appCoordinator.navigate(to: .archive)
                }
            }
            .padding(.horizontal, 23.adjustedWidth)
            
            SolplyTabBar(
                selectedTab: Binding(
                    get: { appCoordinator.selectedTab },
                    set: { appCoordinator.switchTab(to: $0) }
                )
            )
        }
        .shadow(color: .coreBlack.opacity(0.15), radius: 8)
    }
}

#Preview {
    TabBarView()
        .environmentObject(AppCoordinator())
}
