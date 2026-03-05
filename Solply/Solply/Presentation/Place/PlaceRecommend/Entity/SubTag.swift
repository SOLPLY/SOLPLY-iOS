//
//  SubTag.swift
//  Solply
//
//  Created by seozero on 7/18/25.
//

import Foundation

struct SubTag {
    let id: Int
    let tagType: String
    let name: SubTagType
}

extension SubTag {
    init(dto: SubTagDTO) {
        self.id = dto.tagId
        self.tagType = dto.tagType
        self.name = SubTagType(rawValue: dto.name) ?? .art
    }
}
