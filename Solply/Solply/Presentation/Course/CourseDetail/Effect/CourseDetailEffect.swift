//
//  CourseDetailEffect.swift
//  Solply
//
//  Created by 김승원 on 7/9/25.
//

import Foundation

struct CourseDetailEffect {
    
    // TODO: 나중에 API 연결
    func fetchCourseDetailData() -> CourseDetailAction {
        return .courseDetailDataFetched(CourseDetail.mockData())
    }
}
