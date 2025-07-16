//
//  AppDestination.swift
//  Solply
//
//  Created by 김승원 on 6/28/25.
//

import SwiftUI

enum AppDestination: Hashable {
    case archive
    case archiveList(archiveCategory: SolplyContentType, townName: String)
    case placeDetail
    case courseDetail(courseId: Int, fromArchive: Bool)
    case frequentTown
}

extension AppDestination {
    @ViewBuilder
    func build() -> some View {
        switch self {
        case .archive:
            ArchiveView()
        case .archiveList(let archiveCategory, let town):
            ArchiveListView(archiveCategory: archiveCategory, town: town)
        case .placeDetail:
            PlaceDetailView()
        case .courseDetail(let courseId, let fromArchive):
            CourseDetailView(courseId: courseId, fromArchive: fromArchive)
        case .frequentTown:
            FrequentTownView()
        }
    }
}
