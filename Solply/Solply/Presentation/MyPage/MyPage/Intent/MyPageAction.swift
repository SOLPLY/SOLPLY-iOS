//
//  MyPageAction.swift
//  Solply
//
//  Created by sun on 9/19/25.
//

import Foundation

enum MyPageAction {
    case fetchMyPageContent(userId: Int)
    case fetchMySolplyRecords
    case mySolplyRecordsFetched(records: [MySolplyRecord], totalCount: Int)
    case fetchMySolplyRecordsFailed(error: NetworkError)
    case fetchRegisteredPlaces(userId: Int)
    case registeredPlacesFetched([RegisteredPlace])
    case fetchRegisteredPlacesFailed(error: NetworkError)

    case fetchLoginInformation
    case fetchLoginInformationSuccess(loginInformation: SocialLoginType?)
    case fetchLoginInformationFailed(error: NetworkError)
    
    case logout
    case logoutSuccess
    case logoutFailed(error: NetworkError)
}
