//
//  PlaceDetailAction.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

enum PlaceDetailAction {
    case compareUserTownId(userTownId: Int)
    case showTownToast
    
    case toggleAddToCourse
    case toggleBookmarkPlace
    
    case requestFindDirection
    case findDirection(mapRouteType: MapRouteType)
    case findDirectionFinished
    
    case selectCourseToAdd(index: Int)
    
    case showToastView(ToastContent)
    
    case copyToClipboard(text: String)
    
    case updateUserCoordinate(latitude: Double, longitude: Double)
    
    // api
    
    case fetchCourseArchive
    case courseArchiveFetched([CourseArchiveDTO])
    case fetchCourseArchiveFailed(error: NetworkError)
    
    case fetchPlaceDetail
    case placeDetailFetched(placeDetailInformation: PlaceDetailInformation)
    case fetchPlaceDetailFailed(error: NetworkError)
    
    case submitPlaceBookmark
    case placeBookmarkSubmitted
    case submitPlaceBookmarkFailed(error: NetworkError)
    
    case removePlaceBookmark
    case placeBookmarkRemoved
    case removePlaceBookmarkFailed(error: NetworkError)
    
    case submitAddPlace(courseId: Int)
    case addPlaceSubmitted(addPlaceCourseInformation: AddPlaceCourseInformation)
    case submitAddPlaceFailed(error: NetworkError)
    
    case updateUserTowns(newTownId: Int)
    case userTownsUpdated(townName: String)
    case updateUserTownsFailed(error: NetworkError)
}
