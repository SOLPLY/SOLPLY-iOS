//
//  CourseDetailAPI.swift
//  Solply
//
//  Created by 김승원 on 7/16/25.
//

import Foundation

protocol CourseDetailAPI {
    func fetchCourseDetail(
        courseId: Int
    ) async throws -> BaseResponseBody<CourseDetailResponseDTO>
}
