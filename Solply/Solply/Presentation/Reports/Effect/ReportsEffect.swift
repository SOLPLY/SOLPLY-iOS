//
//  ReportsEffect.swift
//  Solply
//
//  Created by 김승원 on 9/25/25.
//

import Foundation

struct ReportsEffect {
    private let fileService: FileAPI
    private let uploadPhotosService: UploadPhotosAPI
    private let placeService: PlaceAPI
    
    init(
        fileService: FileAPI,
        uploadPhotosService: UploadPhotosAPI,
        placeService: PlaceAPI
    ) {
        self.fileService = fileService
        self.uploadPhotosService = uploadPhotosService
        self.placeService = placeService
    }
}

// MARK: - FileAPI

extension ReportsEffect {
    func submitPresignedUrlRequest(request: PresignedUrlRequestDTO) async -> ReportsAction {
        do {
            let response = try await fileService.submitPresignedUrlRequest(request: request)
            
            guard let data = response.data else {
                return .errorOccured(error: .responseError)
            }

            return .presignedUrlRequestSubmitted(response: data)
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
}

// MARK: - UploadPhotoAPI

extension ReportsEffect {
    func uploadImages(dictionary: [URL: Data]) async -> ReportsAction {
        do {
            let response = try await uploadPhotosService.uploadImages(dictionary)
            
            return .photoUploadSuccess(imageKeys: response)
        } catch let error as NetworkError {
            return .photoUploadFailed(error: error)
        } catch {
            return .photoUploadFailed(error: .unknownError)
        }
    }
}

// MARK: - PlaceAPI

extension ReportsEffect {
    func submitReports(placeId: Int, request: ReportsRequestDTO) async -> ReportsAction {
        do {
            let response = try await placeService.submitReports(placeId: placeId, request: request)
            _ = try await Task.sleep(nanoseconds: 2_000_000_000)
            
            guard let _ = response.data else {
                return .errorOccured(error: .responseDecodingError)
            }
            
            return .reportsSubmitted
            
        } catch let error as NetworkError {
            return .reportsFailed(error: error)
        } catch {
            return .reportsFailed(error: .unknownError)
        }
    }
}
