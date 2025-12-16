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
        VStack(alignment: .leading, spacing: 0) {
            archiveBar
            
            archiveGrid
        }
        .customNavigationBar(.archive(backAction: appCoordinator.goBack))
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            store.dispatch(.fetchPlaceThumbnail)
            store.dispatch(.fetchCourseThumbnail)
        }
    }
}

// MARK: - Subviews

extension ArchiveView {
    private var archiveBar: some View {
        ArchiveBar(
            selected: store.state.selectedCategory,
            action: { newCategory in
                store.dispatch(.toggleArchiveBar(archiveCategory: newCategory))
            }
        )
    }
    
    private var archiveGrid: some View {
        Group {
            switch store.state.selectedCategory {
            case .place:
                if store.state.folderThumbnailList.isEmpty {
                    ArchiveEmptyView(archiveCategory: .place)
                        .transition(.move(edge: .leading))
                } else {
                    ArchiveFullView(archiveCategory: .place, store: store)
                        .transition(.move(edge: .leading))
                }

            case .course:
                if store.state.folders.isEmpty {
                    ArchiveEmptyView(archiveCategory: .course)
                        .transition(.move(edge: .trailing))
                } else {
                    ArchiveFullView(archiveCategory: .course, store: store)
                        .transition(.move(edge: .trailing))
                }
            }
        }
        .animation(.easeInOut(duration: 0.2), value: store.state.selectedCategory)
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < -50 {
                        if store.state.selectedCategory != .course {
                            withAnimation {
                                store.dispatch(.toggleArchiveBar(archiveCategory: .course))
                            }
                        }
                    } else if value.translation.width > 50 {
                        if store.state.selectedCategory != .place {
                            withAnimation {
                                store.dispatch(.toggleArchiveBar(archiveCategory: .place))
                            }
                        }
                    }
                }
        )
    }
}
