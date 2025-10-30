//
//  UploadPhotosAPI.swift
//  Solply
//
//  Created by 김승원 on 10/11/25.
//

import Foundation

protocol UploadPhotosAPI {
    func uploadImages(_ dict: [URL: Data]) async throws -> [URL]
}
