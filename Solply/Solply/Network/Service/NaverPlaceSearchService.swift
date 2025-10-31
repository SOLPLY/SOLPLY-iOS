//
//  NaverPlaceSearchService.swift
//  Solply
//
//  Created by 김승원 on 10/30/25.
//

import Foundation

final class NaverPlaceSearchService {
    private let requestURL: String = "https://openapi.naver.com/v1/search/local.json"
    private let displayCount: String = "5"
}

extension NaverPlaceSearchService: NaverPlaceSearchAPI {
    func fetchSearchPlaces(for query: String) async throws -> NaverPlaceSearchResponseDTO {
        print("🔎 [NaverPlaceSearchService] - 검색어: \(query)")
        
        guard var urlComponents = URLComponents(string: requestURL) else {
            throw NetworkError.unknownError
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "display", value: displayCount)
        ]
        
        guard let url = urlComponents.url else {
            throw NetworkError.unknownError
        }
        
        var request = URLRequest(url: url)
        request.addValue(AppEnvironment.naverSearchClientId, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(AppEnvironment.naverSearchClientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.responseError
        }
        
        do {
            let response = try JSONDecoder().decode(NaverPlaceSearchResponseDTO.self, from: data)
            print("🔎 [NaverPlaceSearchService] - 검색 결과:\n \(response)")
            
            return response
        } catch {
            throw NetworkError.responseDecodingError
        }
    }
}
