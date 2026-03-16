//
//  RecordListView.swift
//  Solply
//
//  Created by 김승원 on 3/14/26.
//

import SwiftUI

struct RecordListView: View {
    
    // MARK: - Properites
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store: RecordListStore
    
    // MARK: - Initializer
    
    init() {
        self._store = StateObject(wrappedValue: RecordListStore())
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .center, spacing: 20.adjustedHeight) {
                RecordWriteButton {
                    // TODO: - 기록 작성하기 뷰 연결
                }
                
                recordList
                
                bottomPadding
            }
        }
        .imageViewer(
            item: store.state.imageViewerItem,
            dismissAction: { store.dispatch(.dismissImageViewer) }
        )
        .contentMargins(.top, 8.adjustedHeight)
        .customNavigationBar(.backWithTitle(
            title: "기록",
            backAction: { appCoordinator.goBack() })
        )
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            store.dispatch(.onAppear)
        }
    }
}

// MARK: - Subviews

extension RecordListView {
    private var recordList: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(Array(store.state.records.enumerated()), id: \.offset) { index, record in
                RecordCard(
                    record,
                    hideSeparator: index == store.state.records.count - 1,
                    selectImageAction: { index in
                        store.dispatch(.presentImageViewer(index: index, imageUrls: record.photoUrls))
                    }, reportAction: {
                        appState.requireLoginWithAlert(
                            onAuthenticated: { /* TODO: - 신고 뷰 넘기기 */ },
                            onExplore: { appCoordinator.changeRoot(to: .auth) }
                        )
                    }
                )
            }
        }
    }
    
    private var bottomPadding: some View {
        Rectangle()
            .foregroundStyle(.clear)
            .frame(height: 40.adjustedHeight)
            .frame(maxWidth: .infinity)
    }
}
