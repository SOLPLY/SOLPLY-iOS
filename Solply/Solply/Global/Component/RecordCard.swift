//
//  RecordCard.swift
//  Solply
//
//  Created by 김승원 on 3/14/26.
//

import SwiftUI

import Kingfisher

struct RecordCard: View {
    
    // MARK: - Properties
    
    private let record: Record
    private let hideSeparator: Bool
    private let reportAction: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        _ record: Record,
        hideSeparator: Bool = false,
        reportAction: (() -> Void)? = nil
    ) {
        self.record = record
        self.hideSeparator = hideSeparator
        self.reportAction = reportAction
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.adjustedHeight) {
            userProfile
            
            if !record.photoUrls.isEmpty {
                photos
            }
            
            recordText
            
            visitTimeWithReport
        }
        .padding(.vertical, 20.adjustedHeight)
        .background(.coreWhite)
        .overlay(alignment: .bottom) {
            separator
                .opacity(hideSeparator ? 0 : 1)
        }
    }
}

// MARK: - Subviews

extension RecordCard {
    private var userProfile: some View {
        HStack(alignment: .center, spacing: 8.adjustedWidth) {
            ProfileImage(profileImageUrl: record.profileImageUrl, size: 24.adjusted)
            
            Text(record.userName)
                .applySolplyFont(.body_14_m)
                .foregroundStyle(.coreBlack)
        }
        .padding(.horizontal, 16.adjustedWidth)
    }
    
    private var photos: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 8.adjustedWidth) {
                ForEach(Array(record.photoUrls.enumerated()), id: \.offset) { _, photoUrl in
                    photo(photoUrl)
                }
            }
        }
        .contentMargins(.leading, 16.adjustedWidth, for: .scrollContent)
    }
    
    private var recordText: some View {
        Text(record.recordText)
            .applySolplyFont(.body_14_r)
            .foregroundStyle(.coreBlack)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16.adjustedWidth)
    }
    
    private var visitTimeWithReport: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(record.visitTime)
                .applySolplyFont(.body_14_m)
                .foregroundStyle(.gray600)
            
            Spacer()
            
            Button {
                reportAction?()
            } label: {
                Image(.bellIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24.adjusted, height: 24.adjusted)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16.adjustedWidth)
    }
    
    private var separator: some View {
        Rectangle()
            .foregroundStyle(.gray400)
            .frame(maxWidth: .infinity)
            .frame(height: 0.5.adjustedHeight)
            .padding(.horizontal, 16.adjustedWidth)
    }
    
    private func photo(_ url: String) -> some View {
        KFImage(URL(string: url))
            .aspectRatio(contentMode: .fill)
            .frame(width: 72.adjusted, height: 72.adjusted)
            .cornerRadius(12, corners: .allCorners)
    }
}
