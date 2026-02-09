//
//  TagsService.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

import Moya

final class TagsService: BaseService<TagsTargetType> { }

extension TagsService: TagsAPI {
    func fetchMainTags() async throws -> BaseResponseBody<MainTagsResponseDTO> {
        return try await self.request(with: .fetchMainTags)
    }
    
    func fetchSubTags(tagUsage: String, parentId: Int) async throws -> BaseResponseBody<SubTagsResponseDTO> {
        return try await self.request(with: .fetchSubTags(tagUsage: tagUsage, parentId: parentId))
    }
}
