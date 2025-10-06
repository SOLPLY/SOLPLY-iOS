//
//  PlaceDataView.swift
//  Solply
//
//  Created by LEESOOYONG on 9/26/25.
//

import SwiftUI

struct PlaceDataView: View {
    
    private let places: [PlaceSearchDTO]
    
    init(
        places: [PlaceSearchDTO] = [],
    ) {
        self.places = places
    }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {

                Text("검색 결과 \(places.count)개")
                    .applySolplyFont(.button_14_m)
                    .foregroundColor(.gray800)
                    .frame(height: 18.adjustedHeight)
                    .padding(.horizontal, 20.adjustedWidth)
                    .padding(.bottom, 16.adjustedHeight)

                ForEach(places, id: \.placeId) { place in
                    SearchPlaceCard(
                        thumbnailUrl: place.thumbnailImageUrl,
                        placeName: place.placeName,
                        address: place.address,
                        mainTag: place.primaryTag
                    )
                }

                HStack(alignment: .center, spacing: 0) {
                    Text("찾는 장소가 없어요")
                        .applySolplyFont(.button_14_m)
                        .foregroundColor(.gray700)
                        .padding(.leading, 20.adjustedWidth)

                    Image(.arrowRightIconGray)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24.adjustedWidth, height: 10.adjustedHeight)
                }
                .padding(.top, 16.adjustedHeight)
            }
        }
    }
}
