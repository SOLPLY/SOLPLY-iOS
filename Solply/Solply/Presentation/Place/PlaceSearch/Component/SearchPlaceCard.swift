//
//  SearchPlaceCard.swift
//  Solply
//
//  Created by LEESOOYONG on 9/26/25.
//

import SwiftUI

import Kingfisher

struct SearchPlaceCard: View {
    
    // MARK: - Properties
    
    private let thumnailUrl: String
    private let placeName: String
    private let address: String
    private let mainTag: MainTagType
    
    init(
        thumbnailUrl: String,
        placeName: String,
        address: String,
        mainTag: MainTagType
    ) {
        self.thumnailUrl = thumbnailUrl
        self.placeName = placeName
        self.address = address
        self.mainTag = mainTag
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12.adjustedHeight) {
            Divider()
                .overlay(Color.gray200)
            
            HStack(alignment: .center, spacing: 8.adjustedWidth) {
                KFImage(URL(string: thumnailUrl))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 52.adjusted, height: 52.adjusted)
                    .background(.blue)
                    .cornerRadius(12, corners: .allCorners)
                    .padding(.leading, 20.adjustedWidth)
                
                VStack(alignment: .leading, spacing: 6.adjustedHeight) {
                    
                    HStack(alignment: .center, spacing: 4.adjustedWidth) {
                        
                        PlaceCategoryTag(placeCategory: mainTag)
                        
                        Text(placeName)
                            .applySolplyFont(.title_15_m)
                            .foregroundColor(.black)
                            .frame(height: 19.adjustedHeight, alignment: .leading)
                            .lineLimit(1)
                    }
                    
                    Text(address)
                        .applySolplyFont(.caption_12_r)
                        .foregroundColor(.gray700)
                        .frame(
                            width: 275.adjustedWidth,
                            height: 18.adjustedHeight,
                            alignment: .leading
                        )
                        .lineLimit(1)
                }
            }
            
            Divider()
                .overlay(Color.gray200)
        }
    }
}

//#Preview {
//    SearchPlaceCard(thumbnailUrl: "https://d2ga1f2858oj5h.cloudfront.net/dev/uploads/places/18/place_018_image_1.jpg", placeName: "공간이름", address: "경기도 김포시", mainTag: .cafe)
//}
