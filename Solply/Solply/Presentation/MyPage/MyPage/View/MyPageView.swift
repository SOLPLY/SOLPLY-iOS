//
//  MyPageView.swift
//  Solply
//
//  Created by sun on 9/19/25.
//

import SwiftUI

struct MyPageView: View {

    // MARK: - Properties
    
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
                        places: [] // TODO: API 연결 시 실제 리스트로 교체
                    )
                    .padding(.top, 44.adjustedHeight)

                    MyPageSettings(
//                        loginProvider: store.state.loginProvider,
                        loginProvider: "카카오 로그인",
                        appVersion: "v" + (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"),
                        onTapCustomerCenter: { store.dispatch(.customerCenterTapped) },
                        onTapLogout: { store.dispatch(.logoutTapped) },
                        onTapDeleteAccount: { store.dispatch(.deleteAccountTapped) }
                    )
                    .padding(.top, 16.adjustedHeight)
                }
            }
        }
        .background(Color(.gray100).ignoresSafeArea())
        .customNavigationBar(.myPage(backAction: appCoordinator.goBack))
        .ignoresSafeArea(edges: .bottom)
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

//            Text(store.state.nickname)
            Text("솔플리 화이띵")
                .applySolplyFont(.title_18_sb)
                .foregroundColor(.coreBlack)

            Button {
                appCoordinator.navigate(to: .myPageEdit)
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
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MyPageView()
        .environmentObject(AppCoordinator())
}
