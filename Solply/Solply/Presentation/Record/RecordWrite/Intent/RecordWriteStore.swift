//
//  RecordWriteStore.swift
//  Solply
//
//  Created by sun on 3/21/26.
//

import Foundation

@MainActor
final class RecordWriteStore: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var state = RecordWriteState()
    private let effect: RecordWriteEffect
    
    let placeId: Int
    let placeName: String
    
    // MARK: - Initializer
    
    init(placeId: Int, placeName: String) {
        self.placeId = placeId
        self.placeName = placeName
        self.effect = RecordWriteEffect(placeService: PlaceService())
    }
    
    // MARK: - Dispatch
    
    func dispatch(_ action: RecordWriteAction) {
        RecordWriteReducer.reduce(state: &state, action: action)
        
        switch action {
        case .registerRecordButtonTapped:
            guard let vistedAt = state.selectedDate?.yyyyMMddString,
                  let visitTimeSlot = state.selectedVisitTime else { return }
            
            Task {
                let imageKeyStrings = await PhotoUploadManager.shared.upload(
                    imageDatas: state.selectedPhotos
                )
                
                let request = PlaceRecordWriteRequestDTO(
                    placeId: placeId,
                    visitedAt: vistedAt,
                    visitTimeSlot: visitTimeSlot,
                    content: state.recordText,
                    imageKeys: imageKeyStrings
                )
                
                dispatch(.submitPlaceRecordWrite(request: request))
            }
            
        case .submitPlaceRecordWrite(let request):
            Task {
                let result = await effect.submitPlaceRecordWrite(request: request)
                dispatch(result)
            }
            
        default:
            break
        }
    }
}
