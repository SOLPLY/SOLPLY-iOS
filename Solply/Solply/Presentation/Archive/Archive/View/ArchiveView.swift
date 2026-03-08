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
                withAnimation(.easeInOut(duration: 0.3)) {
                    store.dispatch(.toggleArchiveBar(archiveCategory: selectedCategory))
                }
            }
        )
    }
    
    private var archiveGrid: some View {
        Group {
            if store.state.selectedCategory == .place {
                Group {
                    if store.state.PlacefolderList.isEmpty {
                        ArchiveEmptyView(archiveCategory: .place)
                    } else {
                        ArchiveFullView(archiveCategory: .place, store: store)
                    }
                }
            } else {
                Group {
                    if store.state.CourseFolderList.isEmpty {
                        ArchiveEmptyView(archiveCategory: .course)
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
