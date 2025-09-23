//
//  ArchiveView.swift
//  Solply
//
//  Created by 이수용 on 7/9/25.
//

import SwiftUI

struct ArchiveView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject var store = ArchiveStore()
    
    private let townId: Int
    
    // MARK: - Initializer
    
    init(townId: Int) {
        self.townId = townId
    }
    
    // MARK: - Body
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            ArchiveBar(
                selected: store.state.selectedCategory,
                action: { newCategory in
                    store.dispatch(.toggleArchiveBar(archiveCategory: newCategory))
                }
            )
            
            // TODO: - 데이터 연결 후 데이터 여부에 따라서 분기 처리 필요
            
            Group {
                switch store.state.selectedCategory {
                case .place:
                    if store.state.folderThumbnailList.isEmpty {
                        ArchiveEmptyView(archiveCategory: .place)
                            .transition(.move(edge: .leading))
                    } else {
                        ArchiveFullView(archiveCategory: .place, store: store, townId: townId)
                            .transition(.move(edge: .leading))
                    }

                case .course:
                    if store.state.folders.isEmpty {
                        ArchiveEmptyView(archiveCategory: .course)
                            .transition(.move(edge: .trailing))
                    } else {
                        ArchiveFullView(archiveCategory: .course, store: store, townId: townId)
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
        .frame(maxHeight: .infinity, alignment: .top)
        .customNavigationBar(.archive(backAction: appCoordinator.goBack))
        .onAppear {
            store.dispatch(.fetchPlaceThumbnail)
            store.dispatch(.fetchCourseThumbnail)
        }
    }
}

