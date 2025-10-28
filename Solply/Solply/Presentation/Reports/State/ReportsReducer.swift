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
            break
            
        case .submitPresignedUrlRequest:
            break
            
        case .presignedUrlReqeustSubmitted:
            break
            
        case .submitReports:
            break
            
        case .reportsSubmitted:
            state.shouldGoBack = true
            
        case .photoUploadSuccess:
            print("사진 업로드 성공")
            break
            
        case .photoUploadFailed:
            print("사진 업로드 실패")
            break
        }
    }
}
