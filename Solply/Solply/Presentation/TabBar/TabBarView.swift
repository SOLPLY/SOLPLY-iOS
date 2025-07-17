//
//  TabBarView.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import SwiftUI

import CoreLocation

struct TabBarView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var locationManager = LocationManager()
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            tabContent
            
            tabBar
                .zIndex(10)
                .padding(.bottom, 16.adjustedHeight)
        }
        .onAppear {
            locationManager.requestPermissionAndStartUpdates()
        }
        .customNavigationBar(.recommend(
            filterTitle: "연희동",
            filterAction: {
                appCoordinator.navigate(to: .frequentTown)
            },
            settingAction: {
                
            }
        ))
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
    }
    
    private var tabBar: some View {
        ZStack(alignment: .center) {
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                
                ArchiveButton {
                    appCoordinator.navigate(to: .archive)
                }
            }
            .padding(.horizontal, 20.adjustedWidth)
            
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
