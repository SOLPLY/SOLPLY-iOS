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
        fileService: FileService(),
        uploadPhotosService: UploadPhotosService(),
        placeService: PlaceService()
    )
    
    func dispatch(_ action: ReportsAction) {
        ReportsReducer.reduce(state: &state, action: action)
        
        switch action {
            
        case .changeReportsStep(let reportsStep):
            guard let placeId = state.placeId else { return }
            
            if let selectedReportsType = state.selectedReportsType, reportsStep == .reportsComplete {
                if state.attachedImageData.isEmpty {
                    dispatch(
                        .submitReports(
                            placeId: placeId,
                            request: ReportsRequestDTO(
                                reportType: selectedReportsType.rawValue,
                                content: state.reportsContent,
                                imageKeys: []
                            )
                        )
                    )
                } else {
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
            }
            
        case .submitPresignedUrlRequest(let request):
            Task {
                let result = await effect.submitPresignedUrlRequest(request: request)
                self.dispatch(result)
            }
            
        case .presignedUrlRequestSubmitted(let response):
            let presignedInformation = response.presignedGetUrlInfos
            let imageDatas = state.attachedImageData

            var presignedDictionary: [URL: Data] = [:]

            for (info, data) in zip(presignedInformation, imageDatas) {
                if let url = URL(string: info.presignedUrl) {
                    presignedDictionary[url] = data.1
                }
            }
            
            Task {
                let result = await effect.uploadImages(dictionary: presignedDictionary)
                self.dispatch(result)
            }
            
        case .photoUploadSuccess(let imageKeys):
            guard let reportsType = state.selectedReportsType,
                  let placeId = state.placeId else { return }
            
            var imageKeyStrings: [String]
            
            imageKeyStrings = imageKeys.map { imageKey in
                imageKey.absoluteString.truncated(includeStartRange: "dev", excludeEndRange: "?")
            }
            
            let request = ReportsRequestDTO(
                reportType: reportsType.rawValue,
                content: state.reportsContent,
                imageKeys: imageKeyStrings
            )
            
            self.dispatch(.submitReports(placeId: placeId, request: request))
            
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
