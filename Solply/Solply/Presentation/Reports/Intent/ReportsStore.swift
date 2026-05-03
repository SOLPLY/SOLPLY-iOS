//
//  ReportsStore.swift
//  Solply
//
//  Created by 김승원 on 9/11/25.
//

import Foundation

@MainActor
final class ReportsStore: ObservableObject {
    
    @Published private(set) var state = ReportsState()
    private let effect = ReportsEffect(placeService: PlaceService())
    
    func dispatch(_ action: ReportsAction) {
        ReportsReducer.reduce(state: &state, action: action)
        
        switch action {
            
        case .changeReportsStep(let reportsStep):
            guard let placeId = state.placeId,
                  let selectedReportsType = state.selectedReportsType,
                  reportsStep == .reportsComplete else { return }
            
            Task {
                let imageKeyStrings = await PhotoUploadManager.shared.upload(
                    imageDatas: state.attachedImageData
                )
                
                self.dispatch(
                    .submitReports(
                        placeId: placeId,
                        request: ReportsRequestDTO(
                            reportType: selectedReportsType.rawValue,
                            content: state.reportsContent,
                            imageKeys: imageKeyStrings
                        )
                    )
                )
            }
            
        case .submitReports(let placeId, let request):
            Task {
                let result = await effect.submitReports(placeId: placeId, request: request)
                self.dispatch(result)
            }
            
        default:
            break
        }
    }
}
