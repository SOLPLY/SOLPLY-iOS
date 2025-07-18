//
//  TownService.swift
//  Solply
//
//  Created by 김승원 on 7/15/25.
//

import Foundation

import Moya

final class TownService: BaseService<TownTargetType> { }

extension TownService {
    func fetchTownList() async throws -> BaseResponseBody<TownResponseDTO> {
        return try await self.request(with: .fetchTownList)
    }
}
