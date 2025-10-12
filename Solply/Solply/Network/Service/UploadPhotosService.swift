//
//  UploadPhotosService.swift
//  Solply
//
//  Created by 김승원 on 10/11/25.
//

import Foundation

final class UploadPhotosService { }

extension UploadPhotosService: UploadPhotosAPI {
    func uploadImages(_ dictionary: [URL: Data]) async throws -> [URL] {
        var uploadedUrls: [URL] = []
        
        try await withThrowingTaskGroup(of: URL.self) { group in
            for (presignedUrl, data) in dictionary {
                group.addTask {
                    try await self.uploadToS3(url: presignedUrl, data: data)
                    return presignedUrl
                }
            }
            
            for try await url in group {
                uploadedUrls.append(url)
            }
        }
        
        return uploadedUrls
    }
    
    private func uploadToS3(url: URL, data: Data) async throws {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("image/png", forHTTPHeaderField: "Content-Type")
        _ = try await URLSession.shared.upload(for: request, from: data)
    }
}
