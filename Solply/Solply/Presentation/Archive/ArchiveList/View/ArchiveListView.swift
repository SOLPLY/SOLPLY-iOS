//
//  ArchiveListView.swift
//  Solply
//
//  Created by LEESOOYONG on 7/10/25.
//

import SwiftUI

struct ArchiveListView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject var store = ArchiveListStore()
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 16.adjustedHeight) {
            if store.state.activeDelete {
                HStack {
                    Button {
                        store.dispatch(.toggleSelect)
                        store.dispatch(.toggleCancel)
                    } label: {
                        Text("취소")
                            .applySolplyFont(.button_14_r)
                            .foregroundStyle(.coreBlack)
                            .padding(.top, 10.adjustedHeight)
                            .padding(.leading, 26.adjustedWidth)
                    }

                    Spacer()

                    Button {
                        // MARK: - 삭제 api 연결 예정
                    } label: {
                        Text("삭제")
                            .applySolplyFont(.button_14_r)
                            .foregroundStyle(.coreBlack)
                            .padding(.top, 10.adjustedHeight)
                            .padding(.trailing, 26.adjustedWidth)
                    }
                }
            } else {
                HStack {
                    Spacer()
                    Button {
                        store.dispatch(.toggleSelect)
                    } label: {
                        Text("선택")
                            .applySolplyFont(.button_14_r)
                            .foregroundStyle(.coreBlack)
                            .padding(.top, 10.adjustedHeight)
                            .padding(.trailing, 26.adjustedWidth)
                    }
                }
            }
            ZStack(alignment: .topTrailing) {
                ArchiveListFullView(archiveCatrgory: .course, store: store)
            }
        }
        .customNavigationBar(.archiveList(title: "망원동", backAction: appCoordinator.goBack))
    }
}

#Preview {
    ArchiveListView()
        .environmentObject(AppCoordinator())
}
