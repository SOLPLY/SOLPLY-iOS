//
//  ArchiveFullView.swift
//  Solply
//
//  Created by LEESOOYONG on 7/9/25.
//

import SwiftUI

import Kingfisher

struct ArchiveFullView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    @ObservedObject var store = ArchiveStore()
   
    private let archiveCategory: SolplyContentType
    private let columns = [GridItem(.fixed(165.adjustedWidth)), GridItem(.fixed(165.adjustedWidth))]
    private let title: [String] = ["오감으로 수집하는 하루", "오감자"]
    private let tags: [[PlaceCategoryType]] = [
        [.book, .food],
        [.walk, .unique]
    ]
    
    // MARK: - Initializers
    
    init(archiveCategory: SolplyContentType) {
        self.archiveCategory = archiveCategory
    }
    
    // MARK: - Body

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16.adjustedHeight) {
                ForEach(Array(store.state.folderThumbnailList.enumerated()), id: \.offset) { index, item in
                    archiveCell(index: index, item: item)
                }
            }
            .padding(.top, 16.adjustedHeight)
        }
    }
}

extension ArchiveFullView {
    private func archiveCell(index: Int, item: PlaceArchiveThumbnailDTO) -> some View {
        ZStack(alignment: .center) {
            switch archiveCategory {
            case .place:
                VStack(alignment: .leading, spacing: 8.adjustedHeight) {
                    ZStack {
                        KFImage(URL(string: item.folderThumbnailUrl ?? ""))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)
                        Image(.archiveFrame)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)
                    }
                    
                    Text(item.townName ?? "nil")
                        .applySolplyFont(.title_15_m)
                        .padding(.leading, 8.adjustedWidth)
                }
                .transition(.move(edge: .trailing))

            case .course:
                VStack(alignment: .leading, spacing: 8.adjustedHeight) {
                    ZStack {
                        CourseCard(
                            isSaved: true,
                            title: title[index],
                            courseCategory: tags[index],
                            isSelected: false
                        )
                        .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)

                        Image(.archiveFrame)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)
                    }

                    Text(item.townName ?? "nil")
                        .applySolplyFont(.title_15_m)
                        .padding(.leading, 8.adjustedWidth)
                }
                .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: archiveCategory)
        .onTapGesture {
            appCoordinator.navigate(to: .archiveList(archiveCategory: archiveCategory, townName: item.townName ?? ""))
        }
    }
}
