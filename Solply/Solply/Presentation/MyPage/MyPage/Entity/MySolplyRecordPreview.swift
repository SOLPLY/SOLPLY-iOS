//
//  MySolplyRecordPreview.swift
//  Solply
//
//  Created by 김승원 on 5/11/26.
//

import Foundation

struct MySolplyRecordPreview: Hashable {
    let id: Int
    let placeName: String
    let previewImageUrl: String?
    let content: String
}

extension MySolplyRecordPreview {
    init(dto: ReviewDTO) {
        self.id = dto.reviewId
        self.placeName = dto.placeName
        self.previewImageUrl = dto.previewImageUrl
        self.content = dto.content
    }
}
