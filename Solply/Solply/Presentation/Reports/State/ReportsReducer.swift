//
//  ReportsReducer.swift
//  Solply
//
//  Created by 김승원 on 9/11/25.
//

import Foundation

enum ReportsReducer {
    static func reduce(state: inout ReportsState, action: ReportsAction) {
        switch action {
        case .setPlaceId(let placeId):
            state.placeId = placeId
            
        case .selectReportsType(let reportsType):
            state.selectedReportsType = reportsType
            
        case .changeReportsStep(let reportsStep):
            state.reportsStep = reportsStep
            
        case .editReportsContent(let reportsContent):
            state.reportsContent = reportsContent
            
        case .attachReportsPhoto(let imageData):
            state.attachedImageData = imageData
            
            
        case .errorOccured(let error):
            print(error)
            state.shouldGoBack = true
            break
            
        case .submitPresignedUrlRequest:
            break
            
        case .presignedUrlReqeustSubmitted:
            break
            
        case .submitReports:
            break
            
        case .reportsSubmitted:
            state.shouldGoBack = true
            
        case .reportsFailed(let error):
            print("제보하기에 실패했습니다 error: \(error)")
            break
            
        case .photoUploadSuccess:
            print("S3 사진 업로드 성공")
            break
            
        case .photoUploadFailed(let error):
            print("S3 사진 업로드 실패 error: \(error)")
            break
        }
    }
}
