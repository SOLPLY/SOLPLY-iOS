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
    private let effect = ReportsEffect(
        fileService: FileService()
    )
    
    func dispatch(_ action: ReportsAction) {
        ReportsReducer.reduce(state: &state, action: action)
        
        switch action {
            
        case .changeReportsStep(let reportsStep):
            if reportsStep == .reportsComplete {
                dispatch(.startLottie)
                
                dispatch(
                    .submitPresignedUrlRequest(
                        request: PresignedUrlRequestDTO(
                            files: state.attachedImageData.map { fileName, _ in
                                File(fileName: fileName)
                            }
                        )
                    )
                )
            }
            
        case .submitPresignedUrlRequest(let request):
            Task {
                let result = await effect.submitPresignedUrlRequest(request: request)
                self.dispatch(result)
            }
        
        case .startLottie:
            Task {
                let result = await effect.waitForLottie()
                dispatch(result)
            }
            
        default:
            break
        }
    }
}
