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
        ZStack {
            reportsSelectView
                .offset(
                    x: store.state.reportsStep == .reportsSelect
                    ? 0 : store.state.reportsStep == .reportsDetail
                    ? -screenWidth : -screenWidth
                )
            
            reportsDetailView
                .offset(
                    x: store.state.reportsStep == .reportsSelect
                    ? screenWidth : store.state.reportsStep == .reportsDetail
                    ? 0 : -screenWidth
                )
            
            reportsCompleteView
                .offset(
                    x: store.state.reportsStep == .reportsComplete ? 0 : screenWidth
                )
        }
        .disableSwipeBack()
        .background(.coreWhite)
        .customNavigationBar(
            .reports(
                reportStep: store.state.reportsStep,
                backAction: {
                    backAction()
                }
            )
        )
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            hideKeyboard()
        }
        .onChange(of: store.state.shouldGoBack) { _, newValue in
            if newValue {
                appCoordinator.goBack()
            }
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
        } onPhotosSelected: { imageData in
            store.dispatch(.attachReportsPhoto(imageData: imageData))
        } onCompleteAction: {
            withAnimation(.easeInOut(duration: 0.3)) {
                store.dispatch(.changeReportsStep(reportsStep: .reportsComplete))
            }
        }
    }
    
    private var reportsCompleteView: some View {
        Group {
            if store.state.reportsStep == .reportsComplete {
                ReportsCompleteView()
            }
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
}

#Preview {
    ReportsView()
        .environmentObject(AppCoordinator())
}
