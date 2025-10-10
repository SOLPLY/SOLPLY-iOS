//
//  FileService.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import Foundation

import Moya

final class FileService: BaseService<FileTargetType> { }

extension FileService: FileAPI {
    func submitPresignedUrlRequest(
        request: PresignedUrlRequsetDTO
    ) async throws -> BaseResponseBody<PresignedUrlResponseDTO> {
        return try await self.request(with: .submitPresignedUrlRequest(request: request))
    }
}
