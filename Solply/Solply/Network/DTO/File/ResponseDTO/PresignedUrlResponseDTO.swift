//
//  PresignedUrlResponseDTO.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import Foundation

struct PresignedUrlResponseDTO: ResponseModelType {
    let presignedUrlInfos: [PresignedUrlInformation]
}

struct PresignedUrlInformation: ResponseModelType {
    let originalFileName: String
    let presignedUrl: String
    let tempFileKey: String
    let expirationSeconds: Int
}
