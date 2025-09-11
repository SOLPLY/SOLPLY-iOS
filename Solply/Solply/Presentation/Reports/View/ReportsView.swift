//
//  ReportsView.swift
//  Solply
//
//  Created by 김승원 on 9/11/25.
//

import SwiftUI

struct ReportsView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject private var store = ReportsStore()
    
    // MARK: - Body
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .customNavigationBar(
                .reports(
                    backAction: {
                        appCoordinator.goBack()
                    }
                )
            )
    }
}

#Preview {
    ReportsView()
        .environmentObject(AppCoordinator())
}
