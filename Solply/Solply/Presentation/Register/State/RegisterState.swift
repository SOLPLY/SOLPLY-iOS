//
//  RegisterState.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import Foundation

struct RegisterState {
    var registerStep: RegisterStep = .searchPlace
    var hasSearched: Bool = false
    var isSearchLoading: Bool = false
    
    var placeName: String = ""
    var placeAddress: String? = nil
    var selectedMainTag: MainTagType?
    var selectableSubTagsA: [SelectableSubTag] = [] // selectableSubTagsA.isSelect로 선택 여부 확인
    var selectableSubTagsB: [SelectableSubTag] = []
    var registerContent: String = ""
    var attachedImageData: [(String, Data)] = []
    
    var isCompleteButtonEnabled: Bool = false
    
    var searchResult: [RegisterSearch] = []
}
