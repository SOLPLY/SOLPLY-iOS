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
            
//            Group {
//                if store.state.selectedCategory == .place {
//                    ArchiveEmptyView(archiveCategory: .place)
//                        .transition(.move(edge: .leading))
//                } else {
//                    ArchiveEmptyView(archiveCategory: .course)
//                        .transition(.move(edge: .trailing))
//                }
//            }
//            .animation(.easeInOut(duration: 0.2), value: store.state.selectedCategory)
//        }
//            
        
        Group {
                if store.state.selectedCategory == .place {
                    ArchiveFullView(archiveCategory: .place)
                        .transition(.move(edge: .leading))
                } else {
                    ArchiveFullView(archiveCategory: .course)
                        .transition(.move(edge: .trailing))
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
    }
}
