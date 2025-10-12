//
//  PresignedUrlResponseDTO.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import Foundation

struct PresignedUrlResponseDTO: ResponseModelType {
    let presignedGetUrlInfos: [PresignedUrlInformation]
}

struct PresignedUrlInformation: ResponseModelType {
    let originalFileName: String
    let tempFileKey: String
    let presignedUrl: String
    let expirationSeconds: Int
}
