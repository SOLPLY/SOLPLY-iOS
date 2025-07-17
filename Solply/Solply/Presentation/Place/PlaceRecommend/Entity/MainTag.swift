//
//  MainTag.swift
//  Solply
//
//  Created by seozero on 7/17/25.
//

import Foundation

struct MainTag {
    let id: Int
    let tagType: String
    let name: MainTagType
}

extension MainTag {
    init(dto: MainTagDTO) {
        self.id = dto.tagId
        self.tagType = dto.tagType
        self.name = dto.name
    }
}
