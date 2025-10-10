//
//  PresignedUrlRequsetDTO.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import Foundation

struct PresignedUrlRequsetDTO: RequestModelType {
    let files: [file]
}

struct file: RequestModelType {
    let fileName: String
}
