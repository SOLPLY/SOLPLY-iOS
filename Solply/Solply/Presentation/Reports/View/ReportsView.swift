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
        Group {
            switch store.state.reportsStep {
            case .ReportsSelect:
                reportsSelectView
                
            case .ReportsDetail:
                Text("ReportsDetail")
            case .ReportsComplete:
                Text("ReportsComplete")
            }
        }
        .customNavigationBar(
            .reports(
                backAction: {
                    appCoordinator.goBack()
                }
            )
        )
    }
}

// MARK: - Subviews

extension ReportsView {
    private var reportsSelectView: some View {
        ReportsSelectView(selectedReportsType: store.state.selectedReportsType) { reports in
            store.dispatch(.selectReportsType(reportsType: reports))
        } nextAction: {
            // TODO: - 다음 화면 넘기기
        }
    }
}

#Preview {
    ReportsView()
        .environmentObject(AppCoordinator())
}
