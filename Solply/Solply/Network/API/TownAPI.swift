//
//  TownAPI.swift
//  Solply
//
//  Created by 선영주 on 7/17/25.
//

import Foundation

protocol TownAPI {
    func fetchTownList() async throws -> BaseResponseBody<TownResponseDTO>
}
