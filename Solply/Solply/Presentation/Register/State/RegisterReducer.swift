//
//  RegisterReducer.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import Foundation

enum RegisterReducer {
    static func reduce(state: inout RegisterState, action: RegisterAction) {
        switch action {
        case .updateSearchBarText(let text):
            state.placeName = text
            
        case .selectPlaceToRegister(let placeName, let placeAddress):
            state.placeName = placeName
            state.placeAddress = placeAddress
            state.registerStep = .selectMainTagType
            
        case .selectMainTag(let mainTag):
            state.selectedMainTag = mainTag
            state.registerStep = .selectExtraFeatures
            
        case .selectSubTagA(let selectableSubTags):
            state.selectableSubTagsA = selectableSubTags
            state.isCompleteButtonEnabled = shouldEnableCompleteButton(state)
            
        case .selectSubTagB(let selectableSubTags):
            state.selectableSubTagsB = selectableSubTags
            state.isCompleteButtonEnabled = shouldEnableCompleteButton(state)
            
        case .editReigsterContent(let registerContent):
            state.registerContent = registerContent
            
        case .attachRegisterPhoto(let imageData):
            state.attachedImageData = imageData
            
        case .startRegister:
            break
            
        case .endRegister:
            break
             
        case .errorOccured(let error):
            print(error)
            
        case .fetchSubTags:
            break
            
        case .subTagsFetched(let selectableSubTags):
            state.selectableSubTagsA.removeAll()
            state.selectableSubTagsB.removeAll()
            state.selectableSubTagsA = selectableSubTags.filter { $0.tagType == "OPTION1" }
            state.selectableSubTagsB = selectableSubTags.filter { $0.tagType == "OPTION2" }
            state.isCompleteButtonEnabled = shouldEnableCompleteButton(state)
            
        case .fetchSearchPlaces:
            state.isSearchLoading = true
            break
            
        case .searchPlacesFetched(let places):
            state.searchResult = places
            state.hasSearched = true
            state.isSearchLoading = false
            
        case .fetchSearchPlacesFailed(let error):
            state.searchResult = []
            state.hasSearched = true
            state.isSearchLoading = false
            print(error)
            
        case .submitRegister:
            break
            
        case .registerSubmitted:
            break
            
        case .submitRegisterFailed(let error):
            print(error)
            break
            
        case .submitPresignedUrlRequest:
            break
            
        case .presignedUrlRequestSubmitted:
            break
            
        case .submitPresignedUrlRequestFailed(let error):
            print(error)
            break
            
        case .photoUploadSuccess:
            print("S3 사진 업로드 성공")
            break
            
        case .photoUploadFailed(let error):
            print("S3 사진 업로드 실패 error: \(error)")
            break
        }
    }
}

// MARK: - Functions

extension RegisterReducer {
    private static func shouldEnableCompleteButton(_ state: RegisterState) -> Bool {
           guard state.selectedMainTag != nil else { return false }

           let isSubTagsAEmpty = state.selectableSubTagsA.isEmpty
           let isSubTagsBEmpty = state.selectableSubTagsB.isEmpty

           if isSubTagsAEmpty && isSubTagsBEmpty { return true }

           let isAnySubTagsASelected = isSubTagsAEmpty || state.selectableSubTagsA.contains { $0.isSelected }
           let isAnySubTagsBSelected = isSubTagsBEmpty || state.selectableSubTagsB.contains { $0.isSelected }

           return isAnySubTagsASelected && isAnySubTagsBSelected
       }
}
