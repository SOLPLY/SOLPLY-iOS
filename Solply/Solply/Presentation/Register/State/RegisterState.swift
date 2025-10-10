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
    
    var searchResult: [RegisterSearch] = []
}
