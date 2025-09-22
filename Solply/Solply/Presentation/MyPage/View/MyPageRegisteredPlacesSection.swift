//
//  MyPageRegisteredPlacesSection.swift
//  Solply
//
//  Created by sun on 9/20/25.
//

import SwiftUI

struct MyPageRegisteredPlacesSection: View {
    let places: [Place]
    let emptyText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16.adjustedHeight) {
            Text("내가 등록한 장소")
                .applySolplyFont(.body_16_m)
                .foregroundColor(.coreBlack)

            if places.isEmpty {
                Text(emptyText.isEmpty ? "등록한 장소가 없어요" : emptyText)
                    .applySolplyFont(.body_16_r)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray400)
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 40.adjustedHeight,
                        maxHeight: 40.adjustedHeight,
                        alignment: .center
                    )
            } else {
                // TODO: 나중에 API 연결하면서 손 볼 예정
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 16.adjustedWidth) {
                        ForEach(places) { place in
                            PlaceCard(
                                isSaved: place.isBookmarked,
                                thumbnailUrl: place.thumbnailUrl,
                                placeName: place.placeName,
                                placeCategory: place.mainTag,
                                isSelected: true,
                                size: 145.adjustedWidth
                            ) {
                            }
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

#Preview {
    MyPageRegisteredPlacesSection(
        places: [],
        emptyText: "등록한 장소가 없어요"
    )
}
