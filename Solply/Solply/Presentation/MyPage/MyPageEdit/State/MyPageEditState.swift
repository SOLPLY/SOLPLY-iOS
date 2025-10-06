//
//  MyPageEditState.swift
//  Solply
//
//  Created by sun on 9/26/25.
//

import Foundation

struct MyPageEditState {
    var nickname: String = ""
    var selectedPersona: String? = nil
    var personaOptions: [String] = [
        "이곳저곳 둘러보고 싶어요",
        "취향이 담긴 곳을 찾고 싶어요",
        "자연을 감상하며 쉬고 싶어요"
    ]
}
