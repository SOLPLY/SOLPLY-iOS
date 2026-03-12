//
//  RecmommendCardCourseCount.swift
//  Solply
//
//  Created by sun on 3/12/26.
//

import SwiftUI

struct RecmommendCardCourseCount: View {
    
    let tagType: MainTagType
    let count: Int
    
    init(parentId: Int, count: Int) {
        self.tagType = MainTagType.allCases.first { $0.parentId == parentId } ?? .all
        self.count = count
    }
    
    var body: some View {
        HStack(spacing: 4.adjustedHeight) {
            Image(tagType.icon)
                .resizable()
                .frame(width: 20.adjusted, height: 20.adjusted)
            
            Text("\(tagType.title) \(count)개")
                .applySolplyFont(.body_14_m)
                .foregroundStyle(.gray800)
        }
    }
}
