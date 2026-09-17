//
//  MySolplyRecordsEffect.swift
//  Solply
//
//  Created by 김승원 on 5/8/26.
//

import Foundation

struct MySolplyRecordsEffect {
    private let placeService: PlaceAPI
    
    init(placeService: PlaceAPI) {
        self.placeService = placeService
    }
}

// MARK: - PlaceAPI

extension MySolplyRecordsEffect {
    func fetchMySolplyRecords() async -> MySolplyRecordsAction {
        do {
            let response = try await placeService.fetchMySolplyRecords()
            
            guard let data = response.data else {
                return .fetchMySolplyRecordsFailed(error: .responseError)
            }
            
            let mySolplyRecords = data.reviews.map { MySolplyRecord(dto: $0) }
            
            return .fetchMySolplyRecordsSuccess(mySolplyRecords: mySolplyRecords)
            
        } catch let error as NetworkError {
            return .fetchMySolplyRecordsFailed(error: error)
        } catch {
            return .fetchMySolplyRecordsFailed(error: .unknownError)
        }
    }
    
    func removeMySolplyRecord(reviewId: Int) async -> MySolplyRecordsAction {
        do {
            let _ = try await placeService.removeMySolplyRecord(reviewId: reviewId)
            
            return .removeMySolplyRecordSuccess(reviewId: reviewId)
            
        } catch let error as NetworkError {
            return .removeMySolplyRecordFailed(error: error)
        } catch {
            return .removeMySolplyRecordFailed(error: .unknownError)
        }
    }
}
