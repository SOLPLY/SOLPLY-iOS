//
//  NaverPlaceSearchAPI.swift
//  Solply
//
//  Created by 김승원 on 10/30/25.
//

import Foundation

protocol NaverPlaceSearchAPI {
    /// 네이버 검색
    func fetchSearchPlaces(for query: String) async throws -> NaverPlaceSearchResponseDTO
}
