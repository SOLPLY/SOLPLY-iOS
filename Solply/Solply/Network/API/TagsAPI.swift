//
//  TagsAPI.swift
//  Solply
//
//  Created by 김승원 on 10/11/25.
//

import Foundation

protocol TagsAPI {
    func fetchMainTags() async throws -> BaseResponseBody<MainTagsResponseDTO>
    func fetchSubTags(parentId: Int) async throws -> BaseResponseBody<SubTagsResponseDTO>
}
