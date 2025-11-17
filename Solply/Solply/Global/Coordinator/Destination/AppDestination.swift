//
//  AppDestination.swift
//  Solply
//
//  Created by 김승원 on 6/28/25.
//

import SwiftUI

enum AppDestination: Hashable {
    case archive
    case archiveList(archiveCategory: SolplyContentType, townName: String, townId: Int)
    case placeDetail(townId: Int, placeId: Int, fromSearch: Bool)
    case courseDetail(townId: Int, courseId: Int, fromArchive: Bool)
    case JGD
    case reports(placeId: Int)
    case placeSearch
    case myPage
    case myPageEdit(userInformation: UserInformation)
    case withdraw
    case register
    case registerComplete
}

extension AppDestination {
    @ViewBuilder
    func build() -> some View {
        switch self {
        case .archive:
            ArchiveView()
        case .archiveList(let archiveCategory, let townName, let townId):
            ArchiveListView(archiveCategory: archiveCategory, town: townName, townId: townId)
        case .placeDetail(let townId, let placeId, let fromSearch):
            PlaceDetailView(townId: townId, placeId: placeId, fromSearch: fromSearch)
        case .courseDetail(let townId, let courseId, let fromArchive):
            CourseDetailView(townId: townId, courseId: courseId, fromArchive: fromArchive)
        case .JGD:
            JGDView()
        case .placeSearch:
            PlaceSearchView()
        case .reports(let placeId):
            ReportsView(placeId: placeId)
        case .myPage:
            MyPageView()
        case .myPageEdit(let userInformation):
            MyPageEditView(userInformation: userInformation)
        case .withdraw:
            WithdrawView()
        case .register:
            RegisterView()
        case .registerComplete:
            RegisterCompleteView()
        }
    }
}
