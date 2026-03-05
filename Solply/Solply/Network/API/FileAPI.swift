//
//  FileAPI.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import Foundation

protocol FileAPI {
    /// 임시 업로드용 presigned url 발급
    func submitPresignedUrlRequest(
        request: PresignedUrlRequestDTO
    ) async throws -> BaseResponseBody<PresignedUrlResponseDTO>
}
