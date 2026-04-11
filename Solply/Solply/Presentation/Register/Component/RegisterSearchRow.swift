//
//  RegisterSearchRow.swift
//  Solply
//
//  Created by 김승원 on 10/11/25.
//

import SwiftUI

struct RegisterSearchRow: View {
    
    // MARK: - Properties
    
    private let placeName: String
    private let placeAddress: String
    private let onTap: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        placeName: String,
        placeAddress: String,
        onTap: (() -> Void)? = nil
    ) {
        self.placeName = placeName
        self.placeAddress = placeAddress
        self.onTap = onTap
    }
    
    // MARK: - Body
    
    var body: some View {
        Button {
            onTap?()
        } label: {
            ZStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 7.adjustedHeight) {
                    Text(placeName)
                        .applySolplyFont(.title_15_m)
                        .foregroundStyle(.coreBlack)
                        .lineLimit(1)
                    
                    Text(placeAddress)
                        .applySolplyFont(.caption_12_r)
                        .foregroundStyle(.gray700)
                        .lineLimit(1)
                }
                .frame(height: 52.adjustedHeight)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20.adjustedWidth)
                .padding(.vertical, 12.adjustedHeight)
                .background(.coreWhite)
                
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 1.adjustedHeight)
                    .foregroundStyle(.gray200)
            }
        }
        .buttonStyle(.plain)
    }
}
