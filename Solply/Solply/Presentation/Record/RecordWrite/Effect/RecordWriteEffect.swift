//
//  RecordWriteEffect.swift
//  Solply
//
//  Created by 김승원 on 4/12/26.
//

import Foundation

struct RecordWriteEffect {
    private let placeService: PlaceAPI
    
    init(placeService: PlaceAPI) {
        self.placeService = placeService
    }
}

// MARK: - PlaceAPI

extension RecordWriteEffect {
    func submitPlaceRecordWrite(request: PlaceRecordWriteRequestDTO) async -> RecordWriteAction {
        do {
            let _ = try await placeService.submitPlaceRecordWrite(request: request)
            
            return .submitPlaceRecordWriteSuccess
            
        } catch let error as NetworkError {
            return .submitPlaceRecordWriteFailed(error: error)
        } catch {
            return .submitPlaceRecordWriteFailed(error: .unknownError)
        }
    }
}
