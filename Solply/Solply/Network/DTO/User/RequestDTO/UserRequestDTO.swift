//
//  UserRequestDTO.swift
//  Solply
//
//  Created by 선영주 on 7/18/25.
//

import Foundation

struct UserRequestDTO: RequestModelType {
    let selectedTownId: Int
    let favoriteTownIdList: [Int]
    let persona: String
    let nickname: String
}

extension UserRequestDTO {
    init(selectedTown: Town, favoriteTownList: [Town]) {
        self.selectedTownId = selectedTown.id
        self.favoriteTownIdList = favoriteTownList.map { $0.id }
        self.persona = ""
        self.nickname = ""
    }
}
