//
//  MyPageView.swift
//  Solply
//
//  Created by sun on 9/19/25.
//

import SwiftUI

struct MyPageView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store = MyPageStore()
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(.gray100)
                .ignoresSafeArea(edges: .top)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    header
                    
                    MyPageSection(
                        type: .registeredPlaces,
                        items: store.state.user?.myPlacePreviews ?? [],
                        onSeeAllTapped: {
                            guard let userId = store.state.user?.userId else { return }
                            appCoordinator.navigate(to: .registeredPlaces(userId: userId))
                        }
                    )
                    .padding(.top, 44.adjustedHeight)

                    MyPageSection(
                        type: .record,
                        items: [],
                        onSeeAllTapped: {
                            print("내 솔플리 기록 전체보기")
                        }
                    )
                    .padding(.top, 16.adjustedHeight)
                    
                    MyPageSettings(
                        loginProvider: store.state.loginInformation,
                        appVersion: AppEnvironment.appVersion,
                        onTapCustomerCenter: {
                            appCoordinator.navigate(to: .customerCenter)
                        },
                        onTapLogout: { store.dispatch(.logout) },
                        onTapDeleteAccount: { store.dispatch(.deleteAccountTapped)
                            appCoordinator.navigate(to: .withdraw)
                        }
                    )
                    .padding(.top, 16.adjustedHeight)
                }
                .padding(.bottom, 112.adjustedHeight)
            }
        }
        .onChange(of: store.state.shouldChangeRoot) { _, newValue in
            if newValue {
                appCoordinator.changeRoot(to: .splash)
            }
        }
        .customNavigationBar(
            .titleWithNotification(
                title: "마이페이지",
                notificationAction: { print("알림") }
            )
        )
        .background(.gray100)
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            store.dispatch(.fetchUser)
            store.dispatch(.fetchLoginInformation)
            
            AmplitudeManager.shared.track(.viewMyPage(entryMode: .member))
        }
    }
}

// MARK: - Header

private extension MyPageView {
    var header: some View {
        VStack(alignment: .center, spacing: 15.adjustedHeight) {
            ProfileImage(profileImageUrl: store.state.user?.profileImageUrl)
            
            Text(store.state.user?.nickname ?? "")
                .applySolplyFont(.title_18_sb)
                .foregroundColor(.coreBlack)
            
            Button {
                guard let user = store.state.user else { return }
                
                appCoordinator.navigate(to: .myPageEdit(userInformation: user))
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    Text("프로필 수정")
                        .applySolplyFont(.button_14_m)
                        .foregroundColor(.gray600)
                        .frame(width: 68.adjustedWidth, height: 18.adjustedHeight)
                        .padding(.leading, 12.adjustedWidth)
                    
                    Image(.arrowRightIcon)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                        .foregroundColor(.gray600)
                }
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
