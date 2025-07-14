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
    
    private let archiveCategory: SolplyContentType
    private let town: String
    
    // MARK: - Initializer
    
    init(archiveCategory: SolplyContentType, town: String) {
        self.archiveCategory = archiveCategory
        self.town = town
    }
    
    // MARK: - Body
    
    var body: some View {
        
        VStack(alignment: .trailing, spacing: 16.adjustedHeight) {
            if store.state.activeDelete {
                HStack {
                    Button {
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
                        store.dispatch(.showAlert)
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
                ArchiveListFullView(archiveCategory: archiveCategory, store: store)
            }
        }
        .customNavigationBar(.archiveList(title: town, backAction: appCoordinator.goBack))
        .customAlert(
            alertType: .delete,
            title: "선택한 장소를 삭제할까요?",
            isPresented: store.state.isPresented
        ) {
            store.dispatch(.alertCancel)
        } onConfirm: {
            store.dispatch(.alertDelete)
        }
    }
}

//#Preview {
//    ArchiveListView(archiveCategory: .course)
//        .environmentObject(AppCoordinator())
//}
