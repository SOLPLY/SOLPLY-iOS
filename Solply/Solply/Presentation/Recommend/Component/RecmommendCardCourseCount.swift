//
//  RecmommendCardCourseCount.swift
//  Solply
//
//  Created by sun on 3/12/26.
//

import SwiftUI

struct RecmommendCardCourseCount: View {
    
    // MARK: - Properties
    
    let tagType: MainTagType
    let count: Int
    
    // MARK: - Initializer
    
    init(mainTag: String, count: Int) {
        self.tagType = MainTagType(rawValue: mainTag) ?? .all
        self.count = count
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 4.adjustedWidth) {
            Image(tagType.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 20.adjusted, height: 20.adjusted)
            
            Text("\(tagType.title) \(count)개")
                .applySolplyFont(.body_14_m)
                .foregroundStyle(.gray800)
        }
    }
}
