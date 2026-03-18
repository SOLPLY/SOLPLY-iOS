//
//  PlaceComplaintView.swift
//  Solply
//
//  Created by LEESOOYONG on 3/17/26.
//

import SwiftUI

struct PlaceComplaintView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    // MARK: - Body
    
    var body: some View {
        PlaceComplaintSelectView(
            selectedComplaintType: .none,
            onChangeContent: .none
        )
        .customNavigationBar(
            .backWithTitle(
                title: "신고하기",
                backAction: { appCoordinator.goBack() }
            )
        )
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            hideKeyboard()
        }
    }
}
