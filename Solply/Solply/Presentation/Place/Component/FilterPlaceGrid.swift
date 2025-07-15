//
//  FilterPlaceGrid.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import SwiftUI

struct FilterPlaceGrid: View {
    
    // MARK: - Properties
    
    private let columns = [
        GridItem(.fixed(145.adjustedWidth)),
        GridItem(.fixed(145.adjustedWidth))
    ]
    private let placeCategory: PlaceCategoryType = .all
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 20)
                .fill(.coreWhite)
            
            VStack(alignment: .leading, spacing: 16.adjustedHeight) {
                HStack(alignment: .center, spacing: 8.adjustedWidth) {
                    FilterButton(title: placeCategory.title)
                    
                    FilterButton(title: "추가옵션")
                        .visible(placeCategory == .all ? false : true)
                }
                
                LazyVGrid(columns: columns, spacing: 13.adjustedHeight) {
                    ForEach(0..<10) { index in
                        PlaceCard(
                            isSaved: true,
                            title: "유어마인드",
                            placeCategory: .shopping,
                            isSelected: true,
                            size: 145
                        ) {
                            print("gg")
                        }
                    }
                }
            }
            .padding(.vertical, 20.adjustedHeight)
            .padding(.horizontal, 20.adjustedWidth)
        }
    }
}
