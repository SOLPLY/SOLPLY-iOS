//
//  MyPageRegisteredPlaces.swift
//  Solply
//
//  Created by sun on 9/20/25.
//

import SwiftUI

struct MyPageRegisteredPlaces: View {
    
    
    // MARK: - Properties
    
    private let places: [UserPlace]
    private let emptyText: String
    
    // MARK: - Initializer
    
    init(
        places: [UserPlace],
        emptyText: String = "등록한 장소가 없어요"
    ) {
        self.places = places
        self.emptyText = emptyText
    }

    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.adjustedHeight) {
            Text("내가 등록한 장소")
                .applySolplyFont(.body_16_m)
                .foregroundColor(.coreBlack)
            
            if places.isEmpty {
                Text(emptyText)
                    .applySolplyFont(.body_16_r)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray400)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(height: 40.adjustedHeight)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 16.adjustedWidth) {
                        ForEach(places, id: \.id) { place in
                            PlaceCard(
                                isSaved: place.isBookmarked,
                                thumbnailUrl: place.thumbnail,
                                placeName: place.name,
                                placeCategory: place.mainTag,
                                isSelected: false,
                                size: 145.adjustedWidth
                            )
                        }
                    }
                    .padding(.horizontal, 0)
                }
            }
        }
        .padding(.leading, 20.adjustedWidth)
        .padding(.trailing, 16.adjustedWidth)
        .padding(.vertical, 16.adjustedHeight)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(.coreWhite)
    }
}
