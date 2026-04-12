//
//  RecordListEffect.swift
//  Solply
//
//  Created by 김승원 on 4/12/26.
//

import Foundation

struct RecordListEffect {
    private let placeService: PlaceAPI
    
    init(placeService: PlaceAPI) {
        self.placeService = placeService
    }
}

// MARK: - PlaceAPI

extension RecordListEffect {
    func fetchPlaceRecordList(placeId: Int) async -> RecordListAction {
        do {
            let response = try await placeService.fetchPlaceRecordList(placeId: placeId)
            
            guard let data = response.data else {
                return .fetchPlaceRecordListFailed(error: .responseError)
            }
            
            let records = data.reviews.map { Record($0) }
            
            return .fetchPlaceRecordListSuccess(records: records)
        } catch let error as NetworkError {
            return .fetchPlaceRecordListFailed(error: error)
        } catch {
            return .fetchPlaceRecordListFailed(error: .unknownError)
        }
    }
}
