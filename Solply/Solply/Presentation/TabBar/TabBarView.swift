//
//  TabBarView.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import SwiftUI

struct TabBarView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @EnvironmentObject private var scrollToTopManager: ScrollToTopManager
    @StateObject private var locationManager = LocationManager()
    
    @State private var visitedTabs: Set<TabBarState> = [.place]
    @State private var showOfflineBanner: Bool = false
    @State private var networkMonitor = NetworkMonitor()
    @State private var retryRegistry = RetryRegistry()
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            tabContent
            
            tabBar
                .zIndex(10)
                .padding(.bottom, 16.adjustedHeight)
        }
        .overlay(alignment: .top) {
            if showOfflineBanner {
                OfflineBanner {
                    if networkMonitor.checkConnection() {
                        retryRegistry.reload()
                        showOfflineBanner = false
                    }
                }
                .transition(
                    .move(edge: .top)
                    .combined(with: .opacity)
                )
                .zIndex(20)
            }
        }
        .animation(.easeInOut(duration: 0.4), value: showOfflineBanner)
        .onChange(of: networkMonitor.isConnected) { _, isConnected in
            if !isConnected {
                showOfflineBanner = true
            } else {
                Task {
                    try? await Task.sleep(for: .seconds(1))
                    
                    guard networkMonitor.isConnected else { return }
                    
                    retryRegistry.reload()
                    await appState.fetchUserInformation()
                    trackAmplitudeViewListEvent(appCoordinator.selectedTab)
                    showOfflineBanner = false
                }
            }
        }
        .environment(retryRegistry)
        .onAppear {
            locationManager.requestPermissionAndStartUpdates()
            trackAmplitudeViewListEvent(appCoordinator.selectedTab)
        }
        .onChange(of: appCoordinator.selectedTab) { _, newValue in
            trackAmplitudeViewListEvent(newValue)
        }
//        .task {
//            // TODO: - 유저 정보 받아오는 시점보다 추천뷰 api 호출 시점이 빨라서 문제가 생김
//            await appState.fetchUserInformation()
//            trackAmplitudeViewListEvent(appCoordinator.selectedTab)
//        }
    }
}

// MARK: - Subviews

extension TabBarView {
    private var tabContent: some View {
        ZStack {
            if visitedTabs.contains(.place) {
                PlaceRecommendView()
                    .visible(appCoordinator.selectedTab == .place)
                    .id(retryRegistry.reloadId)
            }
            
            if visitedTabs.contains(.course) {
                CourseRecommendView()
                    .visible(appCoordinator.selectedTab == .course)
                    .id(retryRegistry.reloadId)
            }
            
            if visitedTabs.contains(.bookmark) {
                ArchiveView()
                    .visible(appCoordinator.selectedTab == .bookmark)
                    .id(retryRegistry.reloadId)
            }
            
            if visitedTabs.contains(.myPage) {
                MyPageView()
                    .visible(appCoordinator.selectedTab == .myPage)
                    .id(retryRegistry.reloadId)
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .onChange(of: appCoordinator.selectedTab) { _, newValue in
            visitedTabs.insert(newValue)
        }
    }
    
    private var tabBar: some View {
        SolplyTabBar(
            selectedTab: Binding(
                get: { appCoordinator.selectedTab },
                set: { appCoordinator.switchTab(to: $0) }
            ),
            isAuthenticated: appState.userSession == .authenticated,
            scrollToTopAction: { tabBarState in
                scrollToTopManager.trigger(tabBarState)
            },
            loginRequiredAction: {
                switch appCoordinator.selectedTab {
                case .bookmark:
                    AmplitudeManager.shared.track(.viewLoginRequiredAlert(entryMode: .guest, blockedAction: .openCollectionTab))
                case .myPage:
                    AmplitudeManager.shared.track(.viewLoginRequiredAlert(entryMode: .guest, blockedAction: .openMyPageTab))
                default:
                    break
                }
                
                AlertManager.shared.showAlert(alertType: .authenticationRequired, onCancel: nil) {
                    appCoordinator.changeRoot(to: .auth)
                }
            }
        )
        .shadow(color: .coreBlack.opacity(0.15), radius: 8)
    }
}

// MARK: - Functions

extension TabBarView {
    private func trackAmplitudeViewListEvent(_ selectedTab: TabBarState) {
        switch selectedTab {
        case .place:
            AmplitudeManager.shared.track(.viewPlaceList(townId: appState.townId, townName: appState.townName))
        case .course:
            AmplitudeManager.shared.track(.viewCourseList(townId: appState.townId, townName: appState.townName))
        default:
            break
        }
    }
}
