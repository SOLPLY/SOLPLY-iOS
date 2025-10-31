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
            break
            
        case .searchPlacesFetched(let places):
            state.searchResult = places
            
        case .fetchSearchPlacesFailed(let error):
            state.searchResult = []
            print(error)
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
