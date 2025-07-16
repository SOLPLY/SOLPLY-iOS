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
    @ObservedObject var store: ArchiveStore
    
    private let archiveCategory: SolplyContentType
    private let columns = [GridItem(.fixed(165.adjustedWidth)), GridItem(.fixed(165.adjustedWidth))]
    
    // MARK: - Initializers
    
    init(archiveCategory: SolplyContentType, store: ArchiveStore) {
        self.archiveCategory = archiveCategory
        self.store = store
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16.adjustedHeight) {
                if archiveCategory == .place {
                    ForEach(Array(store.state.folderThumbnailList.enumerated()), id: \.offset) { index, item in
                        archivePlaceCell(index: index, placeItem: item)
                    }
                } else {
                    ForEach(Array(store.state.folders.enumerated()), id: \.offset) { index, item in
                        archiveCourseCell(index: index, courseItem: item)
                    }
                }
            }
            .padding(.top, 16.adjustedHeight)
        }
    }
}

extension ArchiveFullView {
    
    private func archivePlaceCell(index: Int, placeItem: PlaceArchiveThumbnailDTO) -> some View {
        VStack(alignment: .leading, spacing: 8.adjustedHeight) {
            ZStack(alignment: .center) {
                KFImage(URL(string: placeItem.folderThumbnailUrl ?? ""))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)
                
                Image(.archiveFrame)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)
            }
            .cornerRadius(20, corners: .allCorners)
            
            Text(placeItem.townName ?? "")
                .applySolplyFont(.title_15_m)
                .padding(.leading, 8.adjustedWidth)
        }
        .onTapGesture {
            appCoordinator.navigate(
                to: .archiveList(archiveCategory: .place, townName: placeItem.townName ?? "")
            )
        }
        .transition(.move(edge: .trailing))
        .animation(.easeInOut(duration: 0.2), value: archiveCategory)
    }
    
    private func archiveCourseCell(index: Int, courseItem: CourseArchiveThumbnailDTO) -> some View {
        VStack(alignment: .leading, spacing: 8.adjustedHeight) {
            ZStack {
                CourseCard(
                    isSaved: true,
                    title: courseItem.courseName ?? "",
                    imageURL: courseItem.thumbnailUrl ?? "",
                    courseCategory: courseItem.primaryTags?.compactMap {
                        PlaceCategoryType(rawValue: $0)
                    } ?? [],
                    isSelected: false
                )
                .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)
                
                Image(.archiveFrame)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)
                    .cornerRadius(20, corners: .allCorners)
            }
            
            Text(courseItem.townName ?? "")
                .applySolplyFont(.title_15_m)
                .padding(.leading, 8.adjustedWidth)
        }
        .onTapGesture {
            appCoordinator.navigate(
                to: .archiveList(archiveCategory: .course, townName: courseItem.townName ?? "")
            )
        }
        .transition(.move(edge: .leading))
        .animation(.easeInOut(duration: 0.2), value: archiveCategory)
    }
}
