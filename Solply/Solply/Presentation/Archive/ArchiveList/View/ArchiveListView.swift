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
    private let townId: Int
    
    // MARK: - Initializer
    
    init(archiveCategory: SolplyContentType, town: String, townId: Int) {
        self.archiveCategory = archiveCategory
        self.town = town
        self.townId = townId
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
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
                            showAlert()
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
                    ArchiveListFullView(archiveCategory: archiveCategory, store: store, townId: townId)
                }
            }
        }
        .customNavigationBar(.archiveList(title: town, backAction: appCoordinator.goBack))
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            store.dispatch(
                .fetchPlaceList(
                    townId: townId,
                    isBookmarkSearch: true,
                    mainTagId: nil,
                    subTagAIdList: nil,
                    subTagBIdList: nil
                )
            )
            store.dispatch(.fetchCourseList(townId: townId, placeId: nil))
        }
    }
}

// MARK: - Functions

extension ArchiveListView {
    private func showAlert() {
        AlertManager.shared.showAlert(
            alertType: archiveCategory == .place ? .deletePlace : .deleteCourse,
            onCancel: nil
        ) {
            if archiveCategory == .place {
                store.dispatch(.removePlaceList(PlaceIds: Array(store.state.selectedPlaceIds)))
            } else {
                store.dispatch(.removeCourseList(CourseIds: Array(store.state.selectedCourseIds)))
            }
        }
    }
}
