//
//  ReportsEffect.swift
//  Solply
//
//  Created by 김승원 on 9/25/25.
//

import Foundation

struct ReportsEffect {
    private let fileService: FileService
    
    init(fileService: FileService) {
        self.fileService = fileService
    }
}

// MARK: - Functions

extension ReportsEffect {
    func waitForLottie() async -> ReportsAction {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        return .endLottie
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
            
            print(data)
            
            return .presignedUrlReqeustSubmitted
            
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
}
