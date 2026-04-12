//
//  ReportsEffect.swift
//  Solply
//
//  Created by 김승원 on 9/25/25.
//

import Foundation

struct ReportsEffect {
    private let placeService: PlaceAPI
    
    init(
        placeService: PlaceAPI
    ) {
        self.placeService = placeService
    }
}

// MARK: - PlaceAPI

extension ReportsEffect {
    func submitReports(placeId: Int, request: ReportsRequestDTO) async -> ReportsAction {
        do {
            let response = try await placeService.submitReports(placeId: placeId, request: request)
            _ = try await Task.sleep(nanoseconds: 2_000_000_000)
            
            guard let _ = response.data else {
                return .errorOccured(error: .responseDecodingError)
            }
            
            return .reportsSubmitted
            
        } catch let error as NetworkError {
            return .reportsFailed(error: error)
        } catch {
            return .reportsFailed(error: .unknownError)
        }
    }
}
