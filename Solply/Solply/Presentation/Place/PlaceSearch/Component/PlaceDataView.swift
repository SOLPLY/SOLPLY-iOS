//
//  PlaceDataView.swift
//  Solply
//
//  Created by LEESOOYONG on 9/26/25.
//

import SwiftUI

struct PlaceDataView: View {
    
    // MARK: - Properties
    
    private let places: [PlaceSearchDTO]
    private let placeDetailAction: ((Int, Int) -> Void)?
    private let registerAction: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        places: [PlaceSearchDTO] = [],
        placeDetailAction: ((Int, Int) -> Void)? = nil,
        registerAction: (() -> Void)? = nil
    ) {
        self.places = places
        self.placeDetailAction = placeDetailAction
        self.registerAction = registerAction
    }
    
    // MARK: - Body
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 0) {
            Text("검색 결과 \(places.count)개")
                .applySolplyFont(.button_14_m)
                .foregroundColor(.gray800)
                .frame(height: 18.adjustedHeight)
                .padding(.horizontal, 20.adjustedWidth)
                .padding(.bottom, 16.adjustedHeight)
            
            ForEach(places.prefix(3), id: \.placeId) { place in
                SearchPlaceCard(
                    thumbnailUrl: place.thumbnailImageUrl,
                    placeName: place.placeName,
                    address: place.address,
                    mainTag: place.primaryTag,
                )
                .onTapGesture {
                    placeDetailAction?(place.townId, place.placeId)
                }
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
            .onTapGesture {
                registerAction?()
            }
        }
    }
}
