//
//  RegisterState.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import Foundation

struct RegisterState {
    var registerStep: RegisterStep = .selectMainTagType
    
    var placeName: String = ""
    var placeAddress: String? = nil
    
    var searchResult: [RegisterSearch] = []
}
