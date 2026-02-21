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
    @EnvironmentObject private var alertManager: AlertManager
    @EnvironmentObject private var scrollToTopManager: ScrollToTopManager
    @StateObject private var locationManager = LocationManager()
    
    @State private var visitedTabs: Set<TabBarState> = [.place]
    @State private var placeRecommendTitle: String = ""
    @State private var courseRecommendTitle: String = ""
    @State private var isUserInformationLoading: Bool = false
    
    private let userService = UserService()
    
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
        .task {
            await loadUserInfo()
        }
    }
    
    private func loadUserInfo() async {
        print("🌳 [TabBarView] User Information Update")

        switch appState.userSession {
        case .explore:
            placeRecommendTitle = "로그인하고\n취향에 맞는 추천을 받아보세요"
            courseRecommendTitle = "로그인하고\n취향에 맞는 추천을 받아보세요"
            
        case .authenticated:
            do {
                let userInfo = try await fetchUserInformation()
                appState.townName = userInfo.townName
                appState.townId = userInfo.townId
                placeRecommendTitle = "\(userInfo.persona.description)\n\(userInfo.nickname)님을 위한 오늘의 추천"
                courseRecommendTitle = "\(userInfo.persona.description)\n\(userInfo.nickname)님을 위한 오늘의 코스"
            } catch {
                print("사용자 정보 가져오기 실패: \(error)")
            }
        }
    }
}

// MARK: - Subviews

extension TabBarView {
    private var tabContent: some View {
        ZStack {
            if visitedTabs.contains(.place) {
                PlaceRecommendView(
                    title: placeRecommendTitle,
                    isUserInformationLoading: isUserInformationLoading
                )
                .visible(appCoordinator.selectedTab == .place)
            }
            
            if visitedTabs.contains(.course) {
                CourseRecommendView(
                    title: courseRecommendTitle,
                    isUserInformationLoading: isUserInformationLoading
                )
                .visible(appCoordinator.selectedTab == .course)
            }
            
            if visitedTabs.contains(.bookmark) {
                ArchiveView()
                    .visible(appCoordinator.selectedTab == .bookmark)
            }
            
            if visitedTabs.contains(.myPage) {
                MyPageView()
                    .visible(appCoordinator.selectedTab == .myPage)
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
            loginAction: {
                showLoginAlert()
            }
        )
        .shadow(color: .coreBlack.opacity(0.15), radius: 8)
    }
}

// MARK: - Network

extension TabBarView {
    private func fetchUserInformation() async throws -> UserInformation {
        do {
            isUserInformationLoading = true
            
            let response = try await userService.fetchUserInformation()
            
            guard let data = response.data else {
                isUserInformationLoading = true
                throw NetworkError.responseError
            }
            
            isUserInformationLoading = false
            return UserInformation(dto: data)

        } catch let error as NetworkError {
            isUserInformationLoading = true
            throw error
            
        } catch {
            isUserInformationLoading = true
            throw error
        }
    }
}

// MARK: - Functions

extension TabBarView {
    private func showLoginAlert() {
        alertManager.showAlert(alertType: .authenticationRequired, onCancel: nil) {
            appCoordinator.changeRoot(to: .auth)
        }
    }
}
