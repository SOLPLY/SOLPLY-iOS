//
//  DraggablePlaceCell.swift
//  Solply
//
//  Created by 김승원 on 7/8/25.
//

import SwiftUI

import Kingfisher

struct DraggablePlaceCell: View {
    
    // MARK: - Properties
    
    private let order: Int
    private let mainImageURL: String
    private let placeCategoryType: MainTagType
    private let title: String
    private let address: String
    private let isSaved: Bool
    private let isFocused: Bool
    private let isEditing: Bool
    private let saveAction: (() -> Void)?
    private let detailAction: (() -> Void)?
    private let findDirectionAction: (() -> Void)?
    private let tapAction: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        order: Int,
        mainImageURL: String,
        placeCategoryType: MainTagType,
        title: String,
        address: String,
        isSaved: Bool,
        isFocused: Bool,
        isEditing: Bool,
        tapAction: (() -> Void)?,
        detailAction: (() -> Void)?,
        findDirectionAction: (() -> Void)?,
        saveAction: (() -> Void)?
    ) {
        self.order = order
        self.mainImageURL = mainImageURL
        self.placeCategoryType = placeCategoryType
        self.title = title
        self.address = address
        self.saveAction = saveAction
        self.isSaved = isSaved
        self.isFocused = isFocused
        self.isEditing = isEditing
        self.detailAction = detailAction
        self.findDirectionAction = findDirectionAction
        self.tapAction = tapAction
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 15.adjustedWidth) {
            if !isEditing {
                numberBadge
            }
            
            placeCell
        }
    }
}

extension DraggablePlaceCell {
    private var numberBadge: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 20.adjustedWidth, height: 20.adjustedHeight)
                .foregroundStyle(.gray200)
            
            Text("\(order)")
                .applySolplyFont(.caption_12_m)
        }
    }
    
    private var placeCell: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(alignment: .top, spacing: 8.adjustedWidth) {
                KFImage(URL(string: mainImageURL))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        width: isFocused ? 85.adjustedHeight : 50.adjustedWidth,
                        height: isFocused ? 85.adjustedHeight : 50.adjustedHeight
                    )
                    .background(.gray300)
                    .cornerRadius(12, corners: .allCorners)
                
                VStack(alignment: .trailing, spacing: 8.adjustedHeight) {
                    HStack(alignment: .top, spacing: 8.adjustedWidth) {
                        VStack(alignment: .leading, spacing: 6.adjustedHeight) {
                            
                            HStack(alignment: .center, spacing: 4.adjustedWidth) {
                                PlaceCategoryTag(placeCategory: placeCategoryType)
                                
                                Text(title)
                                    .applySolplyFont(.title_15_m)
                                    .frame(height: 19.adjustedHeight)
                                    .foregroundStyle(.coreBlack)
                            }
                            .frame(height: 20.adjustedHeight)
                            
                            Text(address)
                                .applySolplyFont(.caption_12_r)
                                .foregroundStyle(.gray700)
                                .lineLimit(isFocused ? 2 : 1)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Group {
                            if isEditing {
                                Image(.dragDropIcon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                                
                            } else {
                                Button {
                                    saveAction?()
                                } label: {
                                    Image(isSaved ? .bookmarkSavedIcon : .bookmarkIcon)
                                        .resizable()
                                        .renderingMode(.template)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                                        .foregroundStyle(isSaved ? .red500 : .gray400)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.top, 10.adjustedHeight)
                    }
                    .padding(.top, 4.adjustedHeight)
                }
            }
            .padding(.leading, 8.adjustedWidth)
            .padding(.vertical, 8.adjustedHeight)
            .padding(.trailing, 16.adjustedWidth)
            
            if isFocused {
                buttons
            }
        }
        .frame(height: isFocused ? 155.adjustedHeight : 68.adjustedHeight)
        .background(isFocused ? .gray100 : .coreWhite)
        .cornerRadius(20, corners: .allCorners)
        .addBorder(.roundedRectangle(cornerRadius: 20), borderColor: .gray300, borderWidth: 1)
        .onTapGesture {
            if !isEditing {
                withAnimation(.easeInOut(duration: 0.2)) {
                    tapAction?()
                }
            }
        }
    }
    
    private var buttons: some View {
        VStack(alignment: .center, spacing: 0) {
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 1.adjustedHeight)
                .foregroundStyle(.gray300)
            
            HStack(alignment: .center, spacing: 0) {
                Button {
                    findDirectionAction?()
                } label: {
                    Text("길찾기")
                        .applySolplyFont(.button_14_m)
                        .foregroundStyle(.gray800)
                        .frame(width: 145.adjustedWidth, height: 43.adjustedHeight)
                        .background(.gray100)
                }
                .buttonStyle(.plain)
                
                Rectangle()
                    .frame(width: 1.adjustedWidth, height: 43.adjustedHeight)
                    .foregroundStyle(.gray300)
                
                Button {
                    detailAction?()
                } label: {
                    Text("상세보기")
                        .applySolplyFont(.button_14_m)
                        .foregroundStyle(.gray800)
                        .frame(width: 145.adjustedWidth, height: 43.adjustedHeight)
                        .background(.gray100)
                }
                .buttonStyle(.plain)
            }
            .padding(.vertical, 4.adjustedHeight)
        }
    }
}
