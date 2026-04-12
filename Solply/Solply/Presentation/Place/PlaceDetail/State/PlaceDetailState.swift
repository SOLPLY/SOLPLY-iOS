//
//  PlaceDetailState.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

struct PlaceDetailState {
    var isPlaceDetailLoading: Bool = false
    
    var shouldShowTownToast: Bool = false
    var shouldShowFindDirectionDialog: Bool = false
    var isAddToCourseSheetPresented: Bool = false
    
    var bookmarkButtonSelected: Bool = false
    var userLatitude: Double?
    var userLongitude: Double?
    var addPlaceCourseInformation: AddPlaceCourseInformation?
    
    var courses: [AddToCourseArchive] = []
    
    var selectedCourseIndex: Int = -1
    var isPlaceConfirmButtonEnabled: Bool = false
    
    var isBookmarked: Bool = false
    var primaryTag: MainTagType = .all
    var placeName: String = ""
    var introduction: String = ""
    var imageURLs: [String?] = []
    var address: String = ""
    var contactNumber: String = ""
    var openingHours: String = ""
    var snsLink: [PlaceDetailSnsLink] = []
    var latitude: Double?
    var longitude: Double?
    var solplyTips: [SubTagType] = []
    var solplyCheckPoints: [String] = []
    var records: [Record] = []
    var moreRecordsButtonEnabled: Bool = false
    
    var navigationBarTitle: String? = nil
    var imageViewerItem: ImageViewerItem? = nil
}
