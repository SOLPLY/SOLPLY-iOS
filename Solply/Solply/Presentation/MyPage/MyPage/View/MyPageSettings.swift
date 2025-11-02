//
//  MyPageSettings.swift
//  Solply
//
//  Created by sun on 9/20/25.
//

import SwiftUI

struct MyPageSettings: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appCoordinator: AppCoordinator

    private let loginProvider: String
    private let appVersion: String
    private let onTapCustomerCenter: (() -> Void)?
    private let onTapLogout: (() -> Void)?
    private let onTapDeleteAccount: (() -> Void)?

    // MARK: - Initializer

    init(
        loginProvider: String,
        appVersion: String,
        onTapCustomerCenter: (() -> Void)? = nil,
        onTapLogout: (() -> Void)? = nil,
        onTapDeleteAccount: (() -> Void)? = nil
    ) {
        self.loginProvider = loginProvider
        self.appVersion = appVersion
        self.onTapCustomerCenter = onTapCustomerCenter
        self.onTapLogout = onTapLogout
        self.onTapDeleteAccount = onTapDeleteAccount
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("계정 설정")
                .applySolplyFont(.body_16_m)
                .foregroundColor(.coreBlack)
                .padding(.horizontal, 16.adjustedWidth)
                .padding(.top, 16.adjustedHeight)
                .padding(.bottom, 12.adjustedHeight)

            row(title: "고객센터", action: onTapCustomerCenter)

            row(
                title: "로그인 정보",
                trailing: Text(loginProvider)
                    .applySolplyFont(.body_16_r)
                    .foregroundColor(.gray600)
            )

            row(
                title: "앱 버전",
                trailing: Text(appVersion)
                    .applySolplyFont(.body_16_r)
                    .foregroundColor(.gray600)
            )

            row(title: "로그아웃", action: onTapLogout)
            row(title: "탈퇴하기", action: onTapDeleteAccount)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
    }

    // MARK: - Row
    
    private func row(
        title: String,
        trailing: some View = EmptyView(),
        action: (() -> Void)? = nil
    ) -> some View {
        Button {
            action?()
        } label: {
            HStack(alignment: .center, spacing: 0) {
                Text(title)
                    .applySolplyFont(.body_16_r)
                    .foregroundColor(.coreBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)

                trailing
            }
            .padding(.horizontal, 16.adjustedWidth)
            .frame(
                maxWidth: .infinity,
                minHeight: 48.adjustedHeight,
                alignment: .leading
            )
        }
        .buttonStyle(.plain)
        .contentShape(Rectangle())
        .overlay(
            Divider()
                .padding(.horizontal, 16.adjustedWidth),
            alignment: .bottom
        )
    }

}

#Preview {
    MyPageSettings(
        loginProvider: "카카오 로그인",
        appVersion: "v1.0.0",
        onTapCustomerCenter: {},
        onTapLogout: {},
        onTapDeleteAccount: {}
    )
}
