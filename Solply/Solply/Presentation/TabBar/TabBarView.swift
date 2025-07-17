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
        .customNavigationBar(.recommend(
            filterTitle: townName,
            filterAction: {
                appCoordinator.navigate(to: .frequentTown)
            },
            settingAction: {
                
            }
        ))
        .task {
            await loadUserInfo()
        }
    }
    
    private func loadUserInfo() async {
            do {
                let userInfo = try await fetchUserInformation()
                townName = userInfo.townName
                placeRecommendTitle = "\(userInfo.persona)\n\(userInfo.nickname)님을 위한 오늘의 추천)"
                courseRecommendTitle = "\(userInfo.persona)\n\(userInfo.nickname)님을 위한 오늘의 코스"
            } catch {
                print("사용자 정보 가져오기 실패: \(error)")
            }
        }
}

// MARK: - Subviews

extension TabBarView {
    private var tabContent: some View {
        Group {
            PlaceRecommendView(title: placeRecommendTitle)
                .visible(appCoordinator.selectedTab == .place)
            
            CourseRecommendView(title: courseRecommendTitle)
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

// MARK: - Network

extension TabBarView {
    func fetchUserInformation() async throws -> UserInformation {
        do {
            let response = try await userService.fetchUserInformation()
            
            guard let data = response.data else {
                throw NetworkError.responseError
            }
            
            let nickname = data.nickname
            let persona = data.persona
            let townName = data.selectedTown.townName
            
            return UserInformation(
                nickname: nickname,
                persona: persona,
                townName: townName
            )
        } catch let error as NetworkError {
            throw error
            
        } catch {
            throw error
        }
    }
}

#Preview {
    TabBarView()
        .environmentObject(AppCoordinator())
}
