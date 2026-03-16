//
//  ArchiveView.swift
//  Solply
//
//  Created by 이수용 on 7/9/25.
//

import SwiftUI

struct ArchiveView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store = ArchiveStore()
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5.adjustedHeight) {
            archiveBar
            
            archiveGrid
        }
        .customNavigationBar(
            .titleWithNotification(
                title: "수집함",
                notificationAction: { print("알림") }
            )
        )
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            store.dispatch(.fetchPlaceThumbnail)
            store.dispatch(.fetchCourseThumbnail)
            AmplitudeManager.shared.track(.viewCollectionTownList(collectionType: .place))
        }
        .onChange(of: store.state.selectedCategory) { _, newValue in
            AmplitudeManager.shared.track(.viewCollectionTownList(collectionType: AmplitudeCollectionType.from(newValue)))
        }
        .background(.gray100)
    }
}

// MARK: - Subviews

extension ArchiveView {
    private var archiveBar: some View {
        ArchiveBar(
            selected: store.state.selectedCategory,
            action: { selectedCategory in
                store.dispatch(.toggleArchiveBar(archiveCategory: selectedCategory))
            }
        )
    }
    
    private var archiveGrid: some View {
        Group {
            if store.state.selectedCategory == .place {
                Group {
                    if store.state.PlacefolderList.isEmpty {
                        EmptyArchiveButton(contentType: .place) {
                            appCoordinator.switchTab(to: .place)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 215.adjustedHeight)
                    } else {
                        ArchiveFullView(archiveCategory: .place, store: store)
                    }
                }
            } else {
                Group {
                    if store.state.CourseFolderList.isEmpty {
                        EmptyArchiveButton(contentType: .course) {
                            appCoordinator.switchTab(to: .course)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 215.adjustedHeight)
                    } else {
                        ArchiveFullView(archiveCategory: .course, store: store)
                    }
                }
            }
        }
        .padding(.bottom, 112.adjustedHeight)
        .customLoading(
            .archiveFolderLoading,
            isLoading: store.state.isPlaceFolderLoading || store.state.isCourseFolderLoading
        )
    }
}
