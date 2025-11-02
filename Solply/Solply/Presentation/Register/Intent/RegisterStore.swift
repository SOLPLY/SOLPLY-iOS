//
//  RegisterStore.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import Foundation

@MainActor
final class RegisterStore: ObservableObject {
    @Published private(set) var state = RegisterState()
    private let effect = RegisterEffect(
        tagsService: TagsService(),
        naverPlaceSearchService: NaverPlaceSearchService(),
        placeService: PlaceService()
    )
    
    func dispatch(_ action: RegisterAction) {
        RegisterReducer.reduce(state: &state, action: action)
        
        switch action {
            
        case .startRegister:
            if state.attachedImageData.isEmpty {
                self.dispatch(.submitRegister)
                
            } else {
                // TODO: - 사진 첨부 O
            }
            
            
            
        case .fetchSubTags(let parentId):
            Task {
                let result = await effect.fetchSubTags(parentId: parentId)
                self.dispatch(result)
            }
            
        case .fetchSearchPlaces:
            Task {
                let result = await effect.fetchPlaces(for: state.placeName)
                self.dispatch(result)
            }
            
        case  .submitRegister:
            guard let mainTagId = state.selectedMainTag?.parentId else { return }
            
            let subTagAIds = state.selectableSubTagsA
                .filter { $0.isSelected }
                .map { $0.id }
            
            let subTagBIds = state.selectableSubTagsB
                .filter { $0.isSelected }
                .map { $0.id }
            
            Task {
                let result = await effect.submitRegister(
                    request: RegisterRequestDTO(
                        placeName: state.placeName,
                        address: state.placeAddress ?? "",
                        mainTagId: mainTagId,
                        subTagAIds: subTagAIds,
                        subTagBIds: subTagBIds,
                        reason: state.registerContent,
                        images: nil // 일단 사진 없게
                    )
                )
                
                self.dispatch(result)
            }
            
        default:
            break
        }
    }
}
