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
    private let townId: Int
    
    // MARK: - Initializers
    
    init(archiveCategory: SolplyContentType, store: ArchiveListStore, townId: Int) {
        self.archiveCategory = archiveCategory
        self.store = store
        self.townId = townId
    }
    
    // MARK: - Body

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16.adjustedHeight) {
                if archiveCategory == .place {
                    ForEach(Array(store.state.places.enumerated()), id: \.offset) { index, item in
                        archivePlaceCell(index: index, item: item)
                    }
                } else {
                    ForEach(Array(store.state.courses.enumerated()), id: \.offset) { index, item in
                        archiveCourseCell(index: index, item: item)
                    }
                }
            }
            .padding(.top, 16.adjustedHeight)
            .padding(.bottom, 100.adjustedHeight)
        }
    }
}

// MARK: - Functions

extension ArchiveListFullView {
    
    private func archivePlaceCell(index: Int, item: PlaceDTO) -> some View {
        ZStack(alignment: .topTrailing) {
            PlaceCard(
                isSaved: true,
                thumbnailUrl: item.thumbnailImageUrl,
                placeName: item.placeName,
                placeCategory: item.primaryTag,
                isSelected: store.state.selectedPlaceIds.contains(item.placeId),
            ) {
                if store.state.activeDelete {
                    store.dispatch(.togglePlaceArchiveList(placeId: item.placeId))
                } else {
                    appCoordinator.navigate(to: .placeDetail(townId: townId, placeId: item.placeId, fromSearch: false))
                }
                
                if store.state.activeCancel {
                    store.dispatch(.togglePlaceArchiveList(placeId: item.placeId))
                }
            }
            .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)
            .contentShape(Rectangle())
            .padding(.bottom, 32.adjustedHeight)
            
            if store.state.selectedPlaceIds.contains(item.placeId) {
                Image(.checkIcon)
                    .resizable()
                    .frame(width: 36.adjustedWidth, height: 36.adjustedHeight)
                    .padding(.trailing, 12.adjustedWidth)
            }
        }
    }
    
    private func archiveCourseCell(index: Int, item: CourseArchiveDTO) -> some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 8.adjustedHeight) {
                CourseCard(
                    isSaved: true,
                    courseName: item.courseName,
                    imageUrl: item.thumbnailImage,
                    courseCategory: item.mainTags,
                    isSelected: store.state.selectedCourseIds.contains(item.courseId)
                ) {
                    if store.state.activeDelete {
                        store.dispatch(.toggleCourseArchiveList(courseId: item.courseId))
                    } else {
                        appCoordinator.navigate(
                            to: .courseDetail(
                                townId: townId,
                                courseId: item.courseId,
                                fromArchive: true
                            )
                        ) 
                    }
                    
                    if store.state.activeCancel {
                        store.dispatch(.toggleCourseArchiveList(courseId: item.courseId))
                    }
                }
                .frame(width: 165.adjustedWidth, height: 165.adjustedHeight)
                .contentShape(Rectangle())
            }

            if store.state.selectedCourseIds.contains(item.courseId) {
                Image(.checkIcon)
                    .resizable()
                    .frame(width: 36.adjustedWidth, height: 36.adjustedHeight)
                    .padding(.trailing, 12.adjustedWidth)
                    .padding(.top, 12.adjustedHeight)
            }
        }
    }
}

