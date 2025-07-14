//
//  AppDestination.swift
//  Solply
//
//  Created by 김승원 on 6/28/25.
//

import SwiftUI

enum AppDestination: Hashable {
    case archive
    case placeDetail
    case courseDetail(fromArchive: Bool)
}

extension AppDestination {
    @ViewBuilder
    func build() -> some View {
        switch self {
        case .archive:
            ArchiveView()
        case .placeDetail:
            PlaceDetailView()
        case .courseDetail(let fromArchive):
            CourseDetailView(fromArchive: fromArchive)
        }
    }
}
