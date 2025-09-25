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
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .center) {
            reportsSelectView
                .offset(x: calculateScreenOffset(.reportsSelect))

            reportsDetailView
                .offset(x: calculateScreenOffset(.reportsDetail))
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
            withAnimation(.easeInOut(duration: 0.3)) {
                store.dispatch(.changeReportsStep(reportsStep: .reportsDetail))
            }
        }
    }
    
    private var reportsDetailView: some View {
        ReportsDetailView() { reportsContent in
            store.dispatch(.editReportsContent(reportsContent: reportsContent))
        } onPhotosSelected: { imageKeys in
            // TODO: - ReportsState 연결
        } onCompleteAction: {
            // TODO: - 제보 완료 뷰 연결
        }
    }
}

// MARK: - Functions

extension ReportsView {
    private func backAction() {
        if store.state.reportsStep == .reportsDetail {
            withAnimation(.easeIn(duration: 0.2)) {
                store.dispatch(.changeReportsStep(reportsStep: .reportsSelect))
            }
        } else {
            appCoordinator.goBack()
        }
    }
    
    private func calculateScreenOffset(_ reportsStep: ReportsStep) -> CGFloat {
        var offset: CGFloat = 0
        
        switch reportsStep {
        case .reportsSelect:
            offset = store.state.reportsStep == .reportsSelect ? 0 : -screenWidth
        case .reportsDetail:
            offset = store.state.reportsStep == .reportsDetail ? 0 : screenWidth
        }
        
        return offset
    }
}

#Preview {
    ReportsView()
        .environmentObject(AppCoordinator())
}
