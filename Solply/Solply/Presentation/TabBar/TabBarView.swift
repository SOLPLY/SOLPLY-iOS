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
    @StateObject private var locationManager = LocationManager()
    
    @State private var townName: String = ""
    @State private var placeRecommendTitle: String = ""
    @State private var courseRecommendTitle: String = ""
    
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
        
        do {
            let userInfo = try await fetchUserInformation()
            townName = userInfo.townName
            appState.townId = userInfo.townId
            placeRecommendTitle = "\(userInfo.persona.description)\n\(userInfo.nickname)님을 위한 오늘의 추천"
            courseRecommendTitle = "\(userInfo.persona.description)\n\(userInfo.nickname)님을 위한 오늘의 코스"
        } catch {
            print("사용자 정보 가져오기 실패: \(error)")
        }
    }
}

// MARK: - Subviews

extension TabBarView {
    private var tabContent: some View {
        Group {
            PlaceRecommendView(
                title: placeRecommendTitle,
                townName: townName
            )
            .visible(appCoordinator.selectedTab == .place)
            
            CourseRecommendView(
                title: courseRecommendTitle,
                townName: townName
            )
            .visible(appCoordinator.selectedTab == .course)
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    private var tabBar: some View {
        SolplyTabBar(
            selectedTab: Binding(
                get: { appCoordinator.selectedTab },
                set: { appCoordinator.switchTab(to: $0) }
            ), bookmarkAction: {
                print("TabBarView - bookmarkAction")
                appCoordinator.navigate(to: .archive)
            }, myPageAction: {
                print("TabBarView - myPageAction")
                appCoordinator.navigate(to: .myPage)
            }
        )
        .shadow(color: .coreBlack.opacity(0.15), radius: 8)
    }
}

// MARK: - Network

extension TabBarView {
    func fetchUserInformation() async throws -> UserInformation {
        do {
            let response = try await userService.fetchUserInformation()
            
            guard let data = response.data else {
                throw NetworkError.responseError
            }
            
            return UserInformation(dto: data)

        } catch let error as NetworkError {
            throw error
            
        } catch {
            throw error
        }
    }
}

#Preview {
    TabBarView()
        .environmentObject(AppState())
        .environmentObject(AppCoordinator())
        .environmentObject(ToastManager())
}
