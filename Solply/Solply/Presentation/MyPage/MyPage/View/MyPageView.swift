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
                    
                    MyPageRegisteredPlaces(places: store.state.registeredPlaces)
                        .padding(.top, 44.adjustedHeight)
                    
                    MyPageSettings(
                        loginProvider: "카카오 로그인",
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
        }
    }
}

// MARK: - Header

private extension MyPageView {
    var header: some View {
        VStack(alignment: .center, spacing: 15.adjustedHeight) {
            ZStack {
                Circle()
                    .frame(width: 80.adjustedWidth, height: 80.adjustedHeight)
                    .foregroundColor(.gray800)
                
                Image(.myNavIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60.adjustedWidth, height: 60.adjustedHeight)
                    .foregroundColor(.gray100)
            }
            .padding(.top, 24.adjustedHeight)
            
            Text(store.state.user?.nickname ?? "")
                .applySolplyFont(.title_18_sb)
                .foregroundColor(.coreBlack)
            
            Button {
                guard let user = store.state.user else { return }
                
                appCoordinator.navigate(
                    to: .myPageEdit(
                        userInformation: user,
                        profileImageUrl: "" // 임시 프로필 이미지 url 주입
                    )
                )
            } label: {
                HStack(alignment: .center, spacing: 4.adjustedWidth) {
                    Text("프로필 수정")
                        .applySolplyFont(.button_14_m)
                        .foregroundColor(.gray600)
                    
                    Image(.arrowRightIcon)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14.adjustedWidth, height: 14.adjustedWidth)
                        .foregroundColor(.gray600)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

//#Preview {
//    MyPageView()
//        .environmentObject(AppCoordinator())
//}
