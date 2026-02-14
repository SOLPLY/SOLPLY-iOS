//
//  CourseCategoryTag.swift
//  Solply
//
//  Created by 김승원 on 2/14/26.
//

import SwiftUI

struct CourseCategoryTag: View {
    
    // MARK: - Properties
    
    private let courseTagType: CourseTagType
    
    
    // MARK: - Initializer

    init(courseTagType: CourseTagType) {
        self.courseTagType = courseTagType
    }
    
    // MARK: - Body

    var body: some View {
        Text(courseTagType.title)
            .applySolplyFont(.caption_12_m)
            .foregroundStyle(courseTagType.titleColor)
            .padding(.horizontal, 8.adjustedWidth)
            .padding(.vertical, 1.adjustedHeight)
            .background(courseTagType.backgroundColor)
            .capsuleClipped()
    }
}
