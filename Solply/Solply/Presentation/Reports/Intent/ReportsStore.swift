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
            // 1. 제보스탭 3단계 돌입(complete)
            // 사용자가 제보 정보들을 입력하고 호출하는 단계
            // -> reducer - submitPresignedUrlRequest 호출
            if let selectedReportsType = state.selectedReportsType, reportsStep == .reportsComplete {
                if state.attachedImageData.isEmpty {
                    dispatch(
                        .submitReports(
                            placeId: state.placeId,
                            request: ReportsRequestDTO(
                                reportType: selectedReportsType.rawValue,
                                content: state.reportsContent,
                                imageKeys: nil
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
            // 2. effect - submitPresignedUrlRequest 요청
            // PresignedUrl을 발급받는 단계
            // -> 성공) presignedUrlReqeustSubmitted()
            // -> 실패) errorOccured
            // reducer - presignedUrlReqeustSubmitted 호출
            Task {
                let result = await effect.submitPresignedUrlRequest(request: request)
                self.dispatch(result)
            }
            
        case .presignedUrlReqeustSubmitted(let response):
            // 3. effect - reponse를 바탕으로 effect -  uploadImages 호출
            // 사진데이터를 S3 업로드하는 과정
            let presignedInformation = response.presignedGetUrlInfos
            let imageDatas = state.attachedImageData

            var presignedDictionary: [URL: Data] = [:]

            for (info, data) in zip(presignedInformation, imageDatas) {
                if let url = URL(string: info.presignedUrl) {
                    presignedDictionary[url] = data.1
                }
            }
            
            // UploadPhotosService 내부적으로 딕셔너리를 for문으로 돌려서 하나씩 S3에 업로드
            // 성공시 .photoUploadSuccess 호출
            Task {
                let result = await effect.uploadImages(dictionary: presignedDictionary)
                self.dispatch(result)
            }
            
        case .photoUploadSuccess(let imageKeys):
            // 4. S3 업로드 response를 가지고 DTO 생성
            // effect - submitReports호출
            guard let reportsType = state.selectedReportsType, state.placeId > 0 else {
                return
            }
            
            var imageKeyStrings: [String]
            
            imageKeyStrings = imageKeys.map { imageKey in
                imageKey.absoluteString.truncated(includeStartRange: "dev", excludeEndRange: "?")
            }
            
            let request = ReportsRequestDTO(
                reportType: reportsType.rawValue,
                content: state.reportsContent,
                imageKeys: imageKeyStrings
            )
            
            self.dispatch(.submitReports(placeId: state.placeId, request: request))
            
        case .submitReports(let placeId, let request):
            // 5. 제보하기하기 API 호출하는 단계
            Task {
                let result = await effect.submitReports(placeId: placeId, request: request)
                self.dispatch(result)
            }
            
        default:
            break
        }
    }
}
