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
    @EnvironmentObject var alertManager: AlertManager

    private let loginProvider: SocialLoginType?
    private let appVersion: String
    private let onTapCustomerCenter: (() -> Void)?
    private let onTapLogout: (() -> Void)?
    private let onTapDeleteAccount: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        loginProvider: SocialLoginType?,
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
            
            row(title: "로그인 정보", trailing: loginProvider?.loginInformation ?? "")
            row(title: "앱 버전", trailing: appVersion)
            
            row(title: "로그아웃") {
                showLogoutAlert()
            }
            
            row(title: "탈퇴하기", isLast: true, action: onTapDeleteAccount)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white)
    }
    
    // MARK: - Row
    
    private func row(
        title: String,
        trailing: String? = nil,
        isLast: Bool = false,
        action: (() -> Void)? = nil
    ) -> some View {
        HStack(spacing: 0) {
            Text(title)
                .applySolplyFont(.body_16_r)
                .foregroundColor(.coreBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if let trailing {
                Text(trailing)
                    .applySolplyFont(.body_16_r)
                    .foregroundColor(.gray600)
            }
        }
        .padding(.horizontal, 16.adjustedWidth)
        .frame(maxWidth: .infinity, minHeight: 48.adjustedHeight, alignment: .leading)
        .contentShape(Rectangle())
        .background(
            Rectangle()
                .foregroundColor(.white)
        )
        .overlay(
            Group {
                if !isLast {
                    Divider().padding(.horizontal, 16.adjustedWidth)
                }
            },
            alignment: .bottom
        )
        .onTapGesture {
            action?()
        }
    }
    
    // MARK: - Alert
    
    private func showLogoutAlert() {
        alertManager.showAlert(alertType: .logout, onCancel: nil) {
            performLogout()
        }
    }
    
    private func performLogout() {
        onTapLogout?()
    }
}

