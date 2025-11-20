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
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    header
                    
                    MyPageRegisteredPlaces(
                        places: store.state.user?.myPlacePreviews ?? [],
                        onSeeAllTapped: {
                            // TODO: 전체보기> 화면으로 이동하는 로직 추가
                        }
                    )
                    .padding(.top, 44.adjustedHeight)
                    
                    MyPageSettings(
                        loginProvider: store.state.loginInformation,
                        appVersion: "v" + (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"),
                        onTapCustomerCenter: { store.dispatch(.customerCenterTapped) },
                        onTapLogout: { store.dispatch(.logoutTapped) },
                        onTapDeleteAccount: { store.dispatch(.deleteAccountTapped)
                            appCoordinator.navigate(to: .withdraw)
                        }
                    )
                    .padding(.top, 16.adjustedHeight)
                }
            }
        }
        .background(Color(.gray100).ignoresSafeArea())
        .customNavigationBar(.myPage(backAction: appCoordinator.goBack))
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            store.dispatch(.fetchUser)
            store.dispatch(.fetchLoginInformation)
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
                        .frame(width: 64.adjustedWidth, height: 18.adjustedHeight)
                        .padding(.leading, 16.adjustedWidth)
                    
                    Image(.arrowRightIcon)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                        .foregroundColor(.gray600)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
