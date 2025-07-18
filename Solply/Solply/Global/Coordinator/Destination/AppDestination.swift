//
//  AppDestination.swift
//  Solply
//
//  Created by 김승원 on 6/28/25.
//

import SwiftUI

enum AppDestination: Hashable {
    case archive(townId: Int)
    case archiveList(archiveCategory: SolplyContentType, townName: String, townId: Int)
    case placeDetail(townId: Int, placeId: Int)
    case courseDetail(townId: Int, courseId: Int, fromArchive: Bool)
    case frequentTown
}

extension AppDestination {
    @ViewBuilder
    func build() -> some View {
        switch self {
        case .archive(let townId):
            ArchiveView(townId: townId)
        case .archiveList(let archiveCategory, let town, let townId):
            ArchiveListView(archiveCategory: archiveCategory, town: town, townId: townId)
        case .placeDetail(let townId, let placeId):
            PlaceDetailView(townId: townId, placeId: placeId)
        case .courseDetail(let townId, let courseId, let fromArchive):
            CourseDetailView(townId: townId, courseId: courseId, fromArchive: fromArchive)
        case .frequentTown:
            FrequentTownView()
        }
    }
}
