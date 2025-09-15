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
                // TODO: - ReportsCompleteView 연결
                Text("ReportsComplete")
            }
        }
        .background(.coreWhite)
        .customNavigationBar(
            .reports(
                backAction: {
                    backAction()
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
        ReportsSelectView(selectedReportsType: store.state.selectedReportsType) { reportsType in
            store.dispatch(.selectReportsType(reportsType: reportsType))
        } nextAction: {
            store.dispatch(.changeReportsStep(reportsStep: .ReportsDetail))
        }
    }
    
    private var reportsDetailView: some View {
        ReportsDetailView() { reportsContent in
            store.dispatch(.editReportsContent(reportsContent: reportsContent))
        } onPhotosSelected: { imageKeys in
            // TODO: - ReportsState 연결
        } onCompleteAction: {
            store.dispatch(.changeReportsStep(reportsStep: .ReportsComplete))
        }
    }
}

// MARK: - Functions

extension ReportsView {
    private func backAction() {
        if store.state.reportsStep == .ReportsDetail {
            store.dispatch(.changeReportsStep(reportsStep: .ReportsSelect))
        } else {
            appCoordinator.goBack()
        }
    }
}

#Preview {
    ReportsView()
        .environmentObject(AppCoordinator())
}
