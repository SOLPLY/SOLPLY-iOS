//
//  RegisterState.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import Foundation

struct RegisterState {
    var registerStep: RegisterStep = .searchPlace
}

enum RegisterStep {
    case searchPlace
    case selectMainTagType
    case selectExtraFeatures
}
