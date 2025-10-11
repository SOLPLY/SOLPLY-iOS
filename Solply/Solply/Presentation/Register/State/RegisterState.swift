//
//  RegisterState.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import Foundation

struct RegisterState {
    var registerStep: RegisterStep = .searchPlace
    
    var placeName: String = ""
    var placeAddress: String? = nil
    var selectedMainTag: MainTagType?
    var selectableSubTagsA: [SelectableSubTag] = [] // selectableSubTagsA.isSelect로 선택 여부 확인
    var selectableSubTagsB: [SelectableSubTag] = []
    var registerContent: String = ""
    
    var isCompleteButtonEnabled: Bool {
        guard selectedMainTag != nil else { return false }

        let isSubTagsAEmpty = selectableSubTagsA.isEmpty
        let isSubTagsBEmpty = selectableSubTagsB.isEmpty

        if isSubTagsAEmpty && isSubTagsBEmpty { return true }

        let isAnySubTagsASelected = isSubTagsAEmpty || selectableSubTagsA.contains { $0.isSelected }
        let isAnySubTagsBSelected = isSubTagsBEmpty || selectableSubTagsB.contains { $0.isSelected }

        return isAnySubTagsASelected && isAnySubTagsBSelected
    }
    
    var searchResult: [RegisterSearch] = []
}
