//
//  AppDestination.swift
//  Solply
//
//  Created by 김승원 on 6/28/25.
//

import SwiftUI

enum AppDestination: Hashable {
    case archive
    case archiveList(archiveCategory: SolplyContentType, town: String)
    case placeDetail
    case courseDetail(fromArchive: Bool)
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
        case .courseDetail(let fromArchive):
            CourseDetailView(fromArchive: fromArchive)
        }
    }
}
