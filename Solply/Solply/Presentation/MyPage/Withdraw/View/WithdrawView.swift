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
    
    
    var body: some View {
        WithdrawSelectView(
            selectedWithdrawType: store.state.selectedWithdrawType,
            withdrawContent: store.state.withdrawContent,
            onChangeContent: { store.dispatch(.updateContent($0)) },
            withdrawAction: { }
            // TODO: - 탈퇴탈퇴
            )
        .customNavigationBar(
            .withdraw(
                backAction: appCoordinator.goBack
            )
        )
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            hideKeyboard()
        }
    }
}
