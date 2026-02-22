//
//  WithdrawView.swift
//  Solply
//
//  Created by LEESOOYONG on 10/10/25.
//

import SwiftUI

struct WithdrawView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    @ObservedObject var store = WithdrawStore()
    
    // MARK: - Body
    
    var body: some View {
        WithdrawSelectView(
            selectedWithdrawType: store.state.selectedWithdrawType,
            withdrawContent: store.state.withdrawContent,
            onChangeContent: { store.dispatch(.updateContent($0)) },
            selectWithdrawAction: {
                store.dispatch(.selectWithdrawType(withdrawType: $0))
            },
            withdrawAction: {
                showAlert()
                }
            )
        .customNavigationBar(
            .withdraw(
                backAction: appCoordinator.goBack
            )
        )
        .onChange(of: store.state.shouldChangeRoot) { _, newValue in
            if newValue {
                appCoordinator.changeRoot(to: .splash)
            }
        }
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

// MARK: - Functions

extension WithdrawView {
    private func showAlert() {
        AlertManager.shared.showAlert(
            alertType: .withdraw, onCancel: nil
        ) {
            store.dispatch(.withdraw)
        }
    }
}
