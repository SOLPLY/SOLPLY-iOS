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
        case .toggleAddToCourse:
            state.addButtonSelected.toggle()
            state.findDirectionEnabled = state.addButtonSelected ? false : true
            state.bookmarkButtonEnabled = state.addButtonSelected ? false : true
            
        case .toggleBookmarkPlace:
            state.isBookmarked.toggle()
            state.bookmarkButtonSelected.toggle()
            
        case .requestFindDirection:
            break
            
        case .selectCourseToAdd(let index):
            state.selectedCourseIndex = index
            
        case .addPlaceToCourse:
            state.selectedCourseIndex = -1
            
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
            
        case .fetchCourseArchive:
            break
            
        case .courseArchiveFetched(let courseArchive):
            state.courses = courseArchive
            break
            
        case .errorOccured(let error):
            print(error)
            
        case .fetchPlaceDetail:
            break
            
        case .placeDetailFetched(let placeDetail):
            state.isBookmarked = placeDetail.isBookmarked
            state.primaryTag = placeDetail.mainTag
            state.placeName = placeDetail.placeName
            state.introduction = placeDetail.introduction
            
            state.imageURLs = placeDetail.imageInfos.map { $0.url }
            state.address = placeDetail.address
            state.contactNumber = placeDetail.contactNumber ?? ""
            state.openingHours = placeDetail.openingHours.replacingOccurrences(of: "\\n", with: "\n")
            state.snsLink = placeDetail.snsLinks.map {
                PlaceDetailSnsLink(snsPlatform: $0.snsPlatform, url: $0.url)
            }
            state.latitude = Double(placeDetail.latitude) ?? 0.0
            state.longtitude = Double(placeDetail.longitude) ?? 0.0
            state.placeDefaultId = placeDetail.placeDefaultId
            state.placeType = placeDetail.placeType
            
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
            break
            
        case .addPlaceSubmitted:
            print("내 코스에 장소 추가")
            break
            
        case .updateAddPlaceCourseId(let courseId):
            state.addPlaceCourseId = courseId
            
        case .updateUserTowns:
            break
            
        case .userTownsUpdated:
            state.toastContent = ToastContent(
                toastType: .defaultToast,
                message: "동네가 ???으로 변경되었어요."
            )
            
        case .updateUserTownsFailed(let error):
            print(error)
            break
        }
    }
}
