//
//  PlaceDetailAPI.swift
//  Solply
//
//  Created by 김승원 on 7/16/25.
//

import Foundation

protocol PlaceDetailAPI {
    func fetchCourseArchive(
        townId: Int,
        placeId: Int?
    ) async throws -> BaseResponseBody<CourseArchiveResponseDTO>
}
