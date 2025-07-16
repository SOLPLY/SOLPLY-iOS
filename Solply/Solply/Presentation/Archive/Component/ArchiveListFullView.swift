//
//  ArchiveListFullView.swift
//  Solply
//
//  Created by LEESOOYONG on 7/10/25.
//

import SwiftUI

struct ArchiveListFullView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    @ObservedObject var store: ArchiveListStore
   
    private let archiveCategory: SolplyContentType
    private let columns = [GridItem(.fixed(165.adjustedWidth)), GridItem(.fixed(165.adjustedWidth))]
    private let town: [String] = ["망원동", "연희동"]
    private let placeTitle: [String] = ["유어마인드", "내마인드", "니마인드"]
    private let courseTitle: [String] = ["오감으로 수집하는 하루", "오감자", "찍어먹는 오감자"]
    private let tags: [[PlaceCategoryType]] = [
        [.book, .food],
        [.walk, .unique],
        [.shopping, .unique]
    ]
    
    // MARK: - Initializers
    
    init(archiveCategory: SolplyContentType, store: ArchiveListStore) {
        self.archiveCategory = archiveCategory
        self.store = store
    }
    
    // MARK: - Body

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16.adjustedHeight) {
                ForEach(Array(courseTitle.enumerated()), id: \.offset) { index, _ in
                    archiveCell(index: index)
                }
            }
            .padding(.top, 16.adjustedHeight)
        }
    }
}

// MARK: - Functions

extension ArchiveListFullView {
    private func archiveCell(index: Int) -> some View {
        ZStack(alignment: .topTrailing) {
            switch archiveCategory {
            case .place:
                PlaceCard(
                    isSaved: true,
                    title: placeTitle[index],
                    placeCategory: .book,
                    isSelected: store.state.selectedIndex.contains(index)
                ) {
                    if store.state.activeDelete {
                        print(index)
                        store.dispatch(.toggleArchiveList(index: index))
                    } else {
                        // TODO: townId, placeId 바인딩 필요
                        appCoordinator.navigate(to: .placeDetail(townId: 1, placeId: 1))
                    }
                    
                    if store.state.activeCancel {
                        store.dispatch(.toggleArchiveList(index: index))
                    }
                }
                .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)
                .padding(.bottom, 32.adjustedHeight)
                
            case .course:
                VStack(alignment: .leading, spacing: 8.adjustedHeight) {
                    CourseCard(
                        isSaved: true,
                        title: courseTitle[index],
                        courseCategory: tags[index],
                        isSelected: store.state.selectedIndex.contains(index)
                    ) {
                        if store.state.activeDelete {
                            print(index)
                            store.dispatch(.toggleArchiveList(index: index))
                        } else {
                            // TODO: 코스 id 바인딩 필요 지금은 1
                            appCoordinator.navigate(to: .courseDetail(courseId: 1, fromArchive: true))
                        }
                        
                        if store.state.activeCancel {
                            store.dispatch(.toggleArchiveList(index: index))
                        }
                    }
                    .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)
                }
            }

            if store.state.selectedIndex.contains(index) {
                Image(.checkIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 36.adjustedWidth, height: 36.adjustedHeight)
                    .padding(.trailing, 12.adjustedWidth)
                    .padding(.top, archiveCategory == .course ? 12.adjustedHeight : 0)
            }
        }
    }
}
