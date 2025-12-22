//
//  SubTagsResponseDTO.swift
//  Solply
//
//  Created by seozero on 7/18/25.
//

import Foundation

struct SubTagsResponseDTO: ResponseModelType {
    let tags: [SubTagDTO]
}

struct SubTagDTO: ResponseModelType {
    let tagId: Int
    let tagType: String
    let name: String
    let parentId: Int?
}
