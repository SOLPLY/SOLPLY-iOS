//
//  PlaceDetailState.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

struct PlaceDetailState {
    var isPlaceInformationLoading: Bool = false
    
    var shouldShowTownToast: Bool = false
    var shouldShowFindDirectionDialog: Bool = false
    
    var addToCourseButtonSelected: Bool = false
    var bookmarkButtonSelected: Bool = false
    var bookmarkButtonEnabled: Bool = true
    var findDirectionEnabled: Bool = true
    var userLatitude: Double = 0.0
    var userLongitude: Double = 0.0
    var addPlaceCourseInformation: AddPlaceCourseInformation?
    
    var courses: [AddToCourseArchive] = []
    
    var selectedCourseIndex: Int = -1
    
    var isBookmarked: Bool = false
    var primaryTag: MainTagType = .all
    var placeName: String = ""
    var introduction: String = ""
    var imageURLs: [String?] = []
    var address: String = ""
    var contactNumber: String = ""
    var openingHours: String = ""
    var snsLink: [PlaceDetailSnsLink] = []
    var latitude: Double = 0.0
    var longitude: Double = 0.0
}
