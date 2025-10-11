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
            break
            
        case .fetchSubTags:
            break
            
        case .subTagsFetched(let selectableSubTags):
            state.selectableSubTagsA.removeAll()
            state.selectableSubTagsB.removeAll()
            state.selectableSubTagsA = selectableSubTags.filter { $0.tagType == "OPTION1" }
            state.selectableSubTagsB = selectableSubTags.filter { $0.tagType == "OPTION2" }
            state.isCompleteButtonEnabled = shouldEnableCompleteButton(state)
            
            
            
        case .tempAction: // 검색했다고 치고~
            state.searchResult = [
                RegisterSearch(
                    placeName: "공간 이름1이이이이이이이이이이이ㅣ이이이이이이이이이",
                    placeAddress: "상세 주소 1 아아아아아아아아아아아아아아아ㅏ앙아아"
                ),
                RegisterSearch(
                    placeName: "공간 이름2",
                    placeAddress: "상세 주소2"
                ),
                RegisterSearch(
                    placeName: "공간 이름3",
                    placeAddress: "상세 주소3"
                )
            ]
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
