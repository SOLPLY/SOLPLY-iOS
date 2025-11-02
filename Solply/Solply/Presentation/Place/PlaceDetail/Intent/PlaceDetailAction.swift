//
//  PlaceDetailAction.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

enum PlaceDetailAction {
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
    
    case fetchCourseArchive(placeId: Int)
    case courseArchiveFetched([CourseArchiveDTO])
    case errorOccured(error: NetworkError)
    
    case fetchPlaceDetail(placeId: Int)
    case placeDetailFetched(PlaceDetailResponseDTO)
    
    case submitPlaceBookmark(placeId: Int)
    case placeBookmarkSubmitted
    
    case removePlaceBookmark(placeId: Int)
    case placeBookmarkRemoved
    
    case submitAddPlace(courseId: Int, placeId: Int)
    case addPlaceSubmitted
    
    case updateUserTowns(newTownId: Int)
    case userTownsUpdated
    case updateUserTownsFailed(error: NetworkError)
}
