//
//  DraggablePlaceCell.swift
//  Solply
//
//  Created by 김승원 on 7/8/25.
//

import SwiftUI

struct DraggablePlaceCell: View {
    
    // MARK: - Properties
    
    private let mainImageURL: String
    private let placeCategoryType: PlaceCategoryType
    private let title: String
    private let address: String
    private let isSaved: Bool
    private let isFocused: Bool
    private let saveAction: (() -> Void)?
    private let detailAction: (() -> Void)?
    private let findDirectionAction: (() -> Void)?
    private let tapAction: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        mainImageURL: String,
        placeCategoryType: PlaceCategoryType,
        title: String,
        address: String,
        isSaved: Bool,
        isFocused: Bool,
        tapAction: (() -> Void)?,
        detailAction: (() -> Void)?,
        findDirectionAction: (() -> Void)?,
        saveAction: (() -> Void)?
    ) {
        self.mainImageURL = mainImageURL
        self.placeCategoryType = placeCategoryType
        self.title = title
        self.address = address
        self.saveAction = saveAction
        self.isSaved = isSaved
        self.isFocused = isFocused
        self.detailAction = detailAction
        self.findDirectionAction = findDirectionAction
        self.tapAction = tapAction
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .top, spacing: 8.adjustedWidth) {
            Image(.place)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(
                    width: isFocused ? 88.adjustedHeight : 52.adjustedWidth,
                    height: isFocused ? 88.adjustedHeight : 52.adjustedHeight
                )
                .cornerRadius(12, corners: .allCorners)
            
            VStack(alignment: .trailing, spacing: 8.adjustedHeight) {
                HStack(alignment: .center, spacing: 8.adjustedWidth) {
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
                            .frame(height: 18.adjustedHeight)
                            .foregroundStyle(.gray700)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        saveAction?()
                    } label: {
                        Image(isSaved ? .saveIconRed : .saveIconGray)
                            .resizable()
                            .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.top, 4.adjustedHeight)
                
                if isFocused {
                    HStack(alignment: .center, spacing: 8.adjustedWidth) {
                        PlaceCellButton(title: "장소 상세") {
                            detailAction?()
                        }
                        
                        PlaceCellButton(title: "길찾기") {
                            findDirectionAction?()
                        }
                    }
                }
            }
        }
        .padding(.leading, 8.adjustedWidth)
        .padding(.trailing, 16.adjustedWidth)
        .frame(height: isFocused ? 104.adjustedHeight : 68.adjustedHeight)
        .background(isFocused ? .gray100 : .coreWhite)
        .cornerRadius(20, corners: .allCorners)
        .addBorder(.roundedRectangle(cornerRaius: 20), borderColor: .gray300, borderWidth: 1)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.2)) {
                tapAction?()
            }
        }
    }
}
