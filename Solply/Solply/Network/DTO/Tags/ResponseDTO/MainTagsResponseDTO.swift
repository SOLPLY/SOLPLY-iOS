//
//  MainTagsResponseDTO.swift
//  Solply
//
//  Created by seozero on 7/17/25.
//

import Foundation

struct MainTagsResponseDTO: ResponseModelType {
    let tags: [MainTagDTO]
}

struct MainTagDTO: ResponseModelType {
    let tagId: Int
    let tagType: String
    let name: String
    let parentId: Int?
}
