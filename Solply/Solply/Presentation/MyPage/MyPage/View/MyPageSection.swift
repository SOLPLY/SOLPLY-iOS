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
    private let items: [UserPlace]
    private let onSeeAllTapped: (() -> Void)?
    
    private var isEmpty: Bool {
        items.isEmpty
    }
    
    // MARK: - Init
    
    init(
        type: MyPageSectionType,
        items: [UserPlace] = [],
        onSeeAllTapped: (() -> Void)? = nil
    ) {
        self.type = type
        self.items = items
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
                ForEach(items, id: \.id) { item in
                    PlaceCard(
                        isSaved: item.isBookmarked,
                        thumbnailUrl: item.thumbnail,
                        placeName: item.name,
                        placeCategory: item.mainTag,
                        isSelected: false,
                        size: 145.adjusted
                    )
                }
            }
        }
    }
}
