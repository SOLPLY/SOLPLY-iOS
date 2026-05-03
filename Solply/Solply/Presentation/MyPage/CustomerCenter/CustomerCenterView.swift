//
//  CustomerCenterView.swift
//  Solply
//
//  Created by 김승원 on 1/2/26.
//

import SwiftUI

struct CustomerCenterView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    // MARK: - Body
    
    var body: some View {
        WebView(url: AppEnvironment.customerCenterURL)
            .customNavigationBar(
                .backWithTitle(
                    title: "고객센터",
                    backAction: { appCoordinator.goBack() }
                )
            )
            .ignoresSafeArea(edges: .bottom)
    }
}
