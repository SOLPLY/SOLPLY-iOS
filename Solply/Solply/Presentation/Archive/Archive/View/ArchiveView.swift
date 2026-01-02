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
        GeometryReader { geometry in
            ScrollView(.horizontal) {
                LazyHStack(alignment: .center, spacing: 0) {
                    Group {
                        if store.state.PlacefolderList.isEmpty {
                            ArchiveEmptyView(archiveCategory: .place)
                        } else {
                            ArchiveFullView(archiveCategory: .place, store: store)
                        }
                    }
                    .id(SolplyContentType.place)
                    .frame(width: geometry.size.width)
                    
                    Group {
                        if store.state.CourseFolderList.isEmpty {
                            ArchiveEmptyView(archiveCategory: .course)
                        } else {
                            ArchiveFullView(archiveCategory: .course, store: store)
                        }
                    }
                    .id(SolplyContentType.course)
                    .frame(width: geometry.size.width)
                    
                }
                .scrollTargetLayout()
                .animation(.easeInOut(duration: 0.3), value: store.state.selectedCategory)
            }
            .scrollPosition(
                id: Binding(
                    get: { store.state.selectedCategory },
                    set: { selectedCategory in
                        guard let selectedCategory else { return }
                        
                        store.dispatch(.toggleArchiveBar(archiveCategory: selectedCategory))
                    }
                )
            )
            .scrollTargetBehavior(.paging)
            .scrollIndicators(.hidden)
        }
        .customLoading(
            .archiveFolderLoading,
            isLoading: store.state.isPlaceFolderLoading || store.state.isCourseFolderLoading
        )
        .overlay {
            swipeBackArea
        }
    }
    
    private var swipeBackArea: some View {
        HStack(alignment: .center, spacing: 0) {
            Rectangle()
                .fill(.clear)
                .frame(width: 30.adjustedWidth)
                .frame(maxHeight: .infinity)
                .contentShape(Rectangle())
            
            Spacer()
        }
    }
}

#Preview {
    ArchiveView()
        .environmentObject(AppCoordinator())
}
