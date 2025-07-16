//
//  ArchiveEffect.swift
//  Solply
//
//  Created by LEESOOYONG on 7/16/25.
//

import Foundation

struct ArchiveEffect {
    private let service = PlaceService()
    
    func fetchPlaceThumbnail() async -> ArchiveAction {
        do {
            let response = try await service.fetchPlaceThumbnail()
            
            guard let data = response.data else {
                return .errorOccured(error: .responseError)
            }
            
            return .placeThumbnailFetched(placeArchiveThumbnails: data.folderThumbnailList)
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
}
