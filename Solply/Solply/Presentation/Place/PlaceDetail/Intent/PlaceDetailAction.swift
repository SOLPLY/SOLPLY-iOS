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
    
    case selectCourseToAdd(index: Int)
    case addPlaceToCourse(index: Int)
    
    case showToastView(ToastContent)
    
    case copyToClipboard(text: String)
    
    case updateUserCoordinate(latitude: Double, longitude: Double)
    case updateAddPlaceCourseId(courseId: Int)
    
    // api
    
    case fetchCourseArchive
    case courseArchiveFetched([CourseArchiveDTO])
    case errorOccured(error: NetworkError)
    
    case fetchPlaceDetail
    case placeDetailFetched(placeDetailInformation: PlaceDetailInformation)
    
    case submitPlaceBookmark
    case placeBookmarkSubmitted
    
    case removePlaceBookmark
    case placeBookmarkRemoved
    
    case submitAddPlace(courseId: Int)
    case addPlaceSubmitted
    
    case updateUserTowns(newTownId: Int)
    case userTownsUpdated(townName: String)
    case updateUserTownsFailed(error: NetworkError)
}
