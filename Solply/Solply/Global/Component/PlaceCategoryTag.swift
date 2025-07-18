//
//  PlaceCategoryTag.swift
//  Solply
//
//  Created by LEESOOYONG on 7/8/25.
//

import SwiftUI

struct PlaceCategoryTag: View {
    
    // MARK: - Properties
    
    private let placeCategory: MainTagType
    
    // MARK: - Initializer

    init(placeCategory: MainTagType) {
        self.placeCategory = placeCategory
    }
    
    // MARK: - Body

    var body: some View {
        Text(placeCategory.title)
            .applySolplyFont(.body_14_m)
            .foregroundStyle(placeCategory.titleColor ?? .coreWhite)
            .padding(.horizontal, 8.adjustedWidth)
            .padding(.vertical, 1.adjustedHeight)
            .background(placeCategory.backgroundColor)
            .capsuleClipped()
    }
}
