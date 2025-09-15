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
        ZStack(alignment: .center) {
            switch store.state.reportsStep {
            case .ReportsSelect:
                reportsSelectView
                
            case .ReportsDetail:
                reportsDetailView
                
            case .ReportsComplete:
                Text("ReportsComplete")
            }
        }
        .background(.coreWhite)
        .customNavigationBar(
            .reports(
                backAction: {
                    appCoordinator.goBack()
                }
            )
        )
        .onTapGesture {
            hideKeyboard()
        }
    }
}

// MARK: - Subviews

extension ReportsView {
    private var reportsSelectView: some View {
        ReportsSelectView() { reportsType in
            store.dispatch(.selectReportsType(reportsType: reportsType))
        } nextAction: {
            store.dispatch(.changeReportsStep)
        }
    }
    
    private var reportsDetailView: some View {
        ReportsDetailView() { reportsContent in
            store.dispatch(.editReportsContent(reportsContent: reportsContent))
        } onPhotosSelected: { imageKeys in
            // TODO: - ReportsState 연결
        } onCompleteAction: {
            store.dispatch(.changeReportsStep)
        }
    }
}

#Preview {
    ReportsView()
        .environmentObject(AppCoordinator())
}
