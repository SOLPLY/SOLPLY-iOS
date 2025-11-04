//
//  PlaceDetailState.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

struct PlaceDetailState {
    var shouldShowTownToast: Bool = false
    
    var addButtonSelected: Bool = false
    var bookmarkButtonSelected: Bool = false
    var bookmarkButtonEnabled: Bool = true
    var findDirectionEnabled: Bool = true
    var userLatitude: Double = 0.0
    var userLongitude: Double = 0.0
    var addPlaceCourseId: Int?
    
    var courses: [CourseArchiveDTO] = []
    
    var selectedCourseIndex: Int = -1
    
    var toastContent: ToastContent?
    
    var isBookmarked: Bool = false
    var primaryTag: MainTagType = .all
    var placeName: String = ""
    var introduction: String = ""
    var imageURLs: [String] = []
    var address: String = ""
    var contactNumber: String = ""
    var openingHours: String = ""
    var snsLink: [PlaceDetailSnsLink] = []
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var placeDefaultId: Int = -1
    var placeType: String = ""
}
