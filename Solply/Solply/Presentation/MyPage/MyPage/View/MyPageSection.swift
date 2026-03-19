//
//  MyPageSection.swift
//  Solply
//
//  Created by sun on 3/19/26.
//

import SwiftUI

struct MyPageSection: View {
    
    // MARK: - Properties
    
    private let type: MyPageSectionType
    private let places: [UserPlace]?
    private let records: [UserPlace]?
    private let onSeeAllTapped: (() -> Void)?
    
    // MARK: - Init
    
    init(
        type: MyPageSectionType,
        places: [UserPlace]? = nil,
        records: [UserPlace]? = nil,
        onSeeAllTapped: (() -> Void)? = nil
    ) {
        self.type = type
        self.places = places
        self.records = records
        self.onSeeAllTapped = onSeeAllTapped
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.adjustedHeight) {
            headerView
            
            if isEmpty {
                emptyView
            } else {
                contentView
            }
        }
        .padding(.leading, 20.adjustedWidth)
        .padding(.trailing, 16.adjustedWidth)
        .padding(.vertical, 16.adjustedHeight)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(.coreWhite)
    }
    
    // MARK: - Views
    
    private var headerView: some View {
        HStack(alignment: .center) {
            Text(type.title)
                .applySolplyFont(.body_16_m)
                .foregroundColor(.coreBlack)
            
            Spacer()
            
            if !isEmpty, let onSeeAllTapped {
                Button(action: onSeeAllTapped) {
                    HStack(spacing: 9.adjustedWidth) {
                        Text("전체 보기")
                            .applySolplyFont(.body_14_r)
                            .foregroundColor(.gray600)
                        
                        Image(.arrowRightIconGray)
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: 4.adjustedWidth,
                                height: 8.adjustedHeight
                            )
                            .foregroundColor(.gray600)
                    }
                }
                .padding(.trailing, 10.adjustedWidth)
            }
        }
    }
    
    private var emptyView: some View {
        Text(type.emptyText)
            .applySolplyFont(.body_16_r)
            .multilineTextAlignment(.center)
            .foregroundColor(.gray400)
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 40.adjustedHeight)
    }
    
    private var contentView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16.adjustedWidth) {
                switch type {
                case .registeredPlaces:
                    if let places {
                        ForEach(places, id: \.id) { place in
                            PlaceCard(
                                isSaved: place.isBookmarked,
                                thumbnailUrl: place.thumbnail,
                                placeName: place.name,
                                placeCategory: place.mainTag,
                                isSelected: false,
                                size: 145.adjusted
                            )
                        }
                    }
                    
                case .record:
                    if let records {
                        ForEach(records, id: \.id) { record in
                            PlaceCard(
                                isSaved: record.isBookmarked,
                                thumbnailUrl: record.thumbnail,
                                placeName: record.name,
                                placeCategory: record.mainTag,
                                isSelected: false,
                                size: 145.adjusted
                            )
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Helpers
    
    private var isEmpty: Bool {
        switch type {
        case .registeredPlaces:
            return places?.isEmpty ?? true
        case .record:
            return records?.isEmpty ?? true
        }
    }
}
