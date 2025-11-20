//
//  MyPageRegisteredPlaces.swift
//  Solply
//
//  Created by sun on 9/20/25.
//

import SwiftUI

struct MyPageRegisteredPlaces: View {
    
    private let places: [UserPlace]
    private let emptyText: String
    private let onSeeAllTapped: (() -> Void)?
    
    init(
        places: [UserPlace],
        emptyText: String = "등록한 장소가 없어요",
        onSeeAllTapped: (() -> Void)? = nil
    ) {
        self.places = places
        self.emptyText = emptyText
        self.onSeeAllTapped = onSeeAllTapped
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16.adjustedHeight) {
            HStack(alignment: .center) {
                Text("내가 등록한 장소")
                    .applySolplyFont(.body_16_m)
                    .foregroundColor(.coreBlack)
                
                Spacer()
                
                if !places.isEmpty, let onSeeAllTapped {
                    Button(action: onSeeAllTapped) {
                        HStack(spacing: 9.adjustedWidth) {
                            Text("전체 보기")
                                .applySolplyFont(.body_14_r)
                                .foregroundColor(.gray600)
                            
                            Image(.arrowRightIconLightGray)
                                .resizable()
                                .scaledToFit()
                                .frame(
                                    width: 4.adjustedWidth,
                                    height: 8.adjustedHeight
                                )
                        }
                    }
                    .padding(.trailing, 10.adjustedWidth)
                }
            }
            
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
                                placeCategory: MainTagType(rawValue: place.mainTag) ?? .cafe,
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
