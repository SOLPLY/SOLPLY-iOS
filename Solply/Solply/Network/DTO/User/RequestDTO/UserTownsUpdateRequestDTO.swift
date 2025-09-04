//
//  UserTownsUpdateRequestDTO.swift
//  Solply
//
//  Created by sun on 8/26/25.
//

import Foundation

struct UserTownsUpdateRequestDTO: RequestModelType {
    let selectedTownId: Int
    let favoriteTownIdList: [Int]
}

extension UserTownsUpdateRequestDTO {
    init(selectedTown: Town, favoriteTownList: [Town]) {
        self.selectedTownId = selectedTown.id
        self.favoriteTownIdList = favoriteTownList.map { $0.id }
    }
}
