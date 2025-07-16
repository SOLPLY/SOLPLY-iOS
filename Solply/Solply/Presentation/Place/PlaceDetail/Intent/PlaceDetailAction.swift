//
//  PlaceDetailAction.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

enum PlaceDetailAction {
    case toggleAddToCourse
    case toggleSavePlace
    case requestFindDirection
    
    case selectCourseToAdd(index: Int)
    case addPlaceToCourse(index: Int)
    
    case showToastView(ToastContent)
    
    case copyToClipboard(text: String)
    
    // api
    
    case fetchCourseArchive(townId: Int, placeId: Int)
    case courseArchiveFetched([CourseArchiveDTO])
    case errorOccured(error: NetworkError)
    
    case fetchPlaceDetail(placeId: Int)
    case placeDetailFetched(PlaceDetailResponseDTO)
    
    case submitPlaceBookmark(placeId: Int)
    case placeBookmarkSubmited
    
    case removePlaceBookmark(placeId: Int)
    case placeBookmarkRemoved
}
