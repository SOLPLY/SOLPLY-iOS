//
//  TagsResponseDTO.swift
//  Solply
//
//  Created by seozero on 7/17/25.
//

import Foundation

// MARK: - MainTags

struct MainTagsResponseDTO: ResponseModelType {
    let tags: [MainTagDTO]
}

struct MainTagDTO: ResponseModelType {
    let tagId: Int
    let tagType: String
    let name: MainTagType
    let parentId: Int?
}

// MARK: - SubTags

struct SubTagsResponseDTO: ResponseModelType {
    let tags: [SubTagDTO]
}

struct SubTagDTO: ResponseModelType {
    let tagId: Int
    let tagType: String
    let name: SubTagType
    let parentId: Int?
}
