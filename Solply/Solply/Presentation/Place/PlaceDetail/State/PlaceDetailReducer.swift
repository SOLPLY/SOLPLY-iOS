//
//  PlaceDetailReducer.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import UIKit

enum PlaceDetailReducer {
    static func reduce(state: inout PlaceDetailState, action: PlaceDetailAction) {
        switch action {
        case .compareUserTownId:
            break
            
        case .showTownToast:
            state.shouldShowTownToast = true
            
        case .toggleAddToCourse:
            state.addButtonSelected.toggle()
            state.findDirectionEnabled = state.addButtonSelected ? false : true
            state.bookmarkButtonEnabled = state.addButtonSelected ? false : true
            
        case .toggleBookmarkPlace:
            state.isBookmarked.toggle()
            state.bookmarkButtonSelected.toggle()
            
        case .requestFindDirection:
            state.shouldShowFindDirectionDialog = true
            
        case .findDirectionFinished:
            state.shouldShowFindDirectionDialog = false
            
        case .findDirection:
            break
            
        case .selectCourseToAdd(let index):
            state.selectedCourseIndex = index
            
        case .showToastView(let toastContent):
            state.toastContent = toastContent
            
        case .copyToClipboard(let text):
            UIPasteboard.general.string = text
                if UIPasteboard.general.string == text {
                    print("✅ 클립보드에 복사 성공")
                } else {
                    print("❌ 클립보드 복사 실패")
                }
            
        case .updateUserCoordinate(latitude: let latitude, longitude: let longitude):
            state.userLatitude = latitude
            state.userLongitude = longitude
            
        // api
            
        case .fetchCourseArchive:
            break
            
        case .courseArchiveFetched(let addToCourseArchive):
            state.courses = addToCourseArchive
            break
            
        case .fetchPlaceDetail:
            state.isPlaceInformationLoading = true
            break
            
        case .placeDetailFetched(let placeDetailInformation):
            state.isPlaceInformationLoading = false
            state.isBookmarked = placeDetailInformation.isBookmarked
            state.primaryTag = placeDetailInformation.primaryTag
            state.placeName = placeDetailInformation.placeName
            state.introduction = placeDetailInformation.introduction
            state.imageURLs = placeDetailInformation.imageUrls
            state.address = placeDetailInformation.address
            state.contactNumber = placeDetailInformation.contactNumber
            state.openingHours = placeDetailInformation.openingHours
            state.snsLink = placeDetailInformation.snsLink
            state.latitude = placeDetailInformation.latitude
            state.longitude = placeDetailInformation.longitude
            
        case .submitPlaceBookmark:
            break
            
        case .placeBookmarkSubmitted:
            print("장소 저장 완료")
            break
            
        case .removePlaceBookmark:
            break
            
        case .placeBookmarkRemoved:
            print("장소 저장 취소 완료")
            break
            
        case .submitAddPlace:
            state.selectedCourseIndex = -1
            break
            
        case .addPlaceSubmitted(let addPlaceCourseInformation):
            state.addPlaceCourseInformation = addPlaceCourseInformation
            break
            
        case .updateUserTowns:
            break
            
        case .userTownsUpdated:
            state.shouldShowTownToast = false
            
        case .updateUserTownsFailed(let error):
            print(error)
            break
            
        // errors
            
        case .fetchCourseArchiveFailed(let error):
            print(error)
            
        case .fetchPlaceDetailFailed(let error):
            state.isPlaceInformationLoading = true
            print(error)
            
        case .submitPlaceBookmarkFailed(let error):
            print(error)
            
        case .removePlaceBookmarkFailed(let error):
            print(error)
            
        case .submitAddPlaceFailed(let error):
            print(error)
        }
    }
}
