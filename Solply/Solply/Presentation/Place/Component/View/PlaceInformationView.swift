//
//  PlaceInformationView.swift
//  Solply
//
//  Created by 김승원 on 7/14/25.
//

import SwiftUI

import Kingfisher

struct PlaceInformationView: View {
    
    // MARK: - Properties
    
    @Environment(\.openURL) private var openURL
    
    private let primaryTag: MainTagType
    private let placeName: String
    private let introduction: String
    private let imageURLs: [String]
    private let address: String
    private let contactNumber: String
    private let openingHours: String
    private let snsLink: [PlaceDetailSnsLink]
    private let copyAction: ((String) -> Void)?
    
    // MARK: - Initializer
    
    init(
        primaryTag: MainTagType,
        placeName: String,
        introduction: String,
        imageURLs: [String],
        address: String,
        contactNumber: String,
        openingHours: String,
        snsLink: [PlaceDetailSnsLink],
        copyAction: ((String) -> Void)? = nil
    ) {
        self.primaryTag = primaryTag
        self.placeName = placeName
        self.introduction = introduction
        self.imageURLs = imageURLs
        self.address = address
        self.contactNumber = contactNumber
        self.openingHours = openingHours
        self.snsLink = snsLink
        self.copyAction = copyAction
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 16.adjustedHeight) {
                title
                
                mainImage
                
                information
            }
        }
    }
}

extension PlaceInformationView {
    private var title: some View {
        VStack(alignment: .leading, spacing: 4.adjustedHeight) {
            HStack(alignment: .center, spacing: 8.adjustedWidth) {
                PlaceCategoryTag(placeCategory: primaryTag)
                
                Text(placeName)
                    .applySolplyFont(.title_18_sb)
                    .foregroundStyle(.coreBlack)
                    .frame(height: 23.adjustedHeight)
            }
            
            Text(introduction)
                .applySolplyFont(.caption_14_r)
                .foregroundStyle(.gray900)
                .frame(height: 21.adjustedHeight)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20.adjustedWidth)
    }
    
    private var mainImage: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 12.adjustedWidth) {
                ForEach(imageURLs, id: \.self) { imageURL in
                    KFImage(URL(string: imageURL))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width - 32.adjustedWidth, height: 228.adjustedHeight)
                        .cornerRadius(20, corners: .allCorners)
                }
            }
            .scrollTargetLayout()
            .padding(.horizontal, 16.adjustedWidth)
        }
        .scrollTargetBehavior(.viewAligned)
    }
    
    private var information: some View {
        VStack(alignment: .leading, spacing: 8.adjustedHeight) {
            PlaceInformationWithCopyRow(title: "주소", value: address) {
                copyAction?(address)
            }
            
            if !contactNumber.isEmpty {
                PlaceInformationWithCopyRow(title: "전화번호", value: contactNumber) {
                    copyAction?(contactNumber)
                }
            } else {
                PlaceInformationRow(title: "전화번호", value: "")
            }
            
            PlaceInformationRow(title: "운영시간", value: openingHours)
            if !snsLink.isEmpty {
                PlaceInformationRow(title: "바로가기", value: snsLink[0].snsPlatform) {
                    if let url = URL(string: snsLink[0].url) {
                        openURL(url)
                    }
                }
            }
        }
        .padding(.vertical, 16.adjustedHeight)
        .padding(.horizontal, 20.adjustedWidth)
        .frame(maxWidth: .infinity, alignment: .leading)
        .addBorder(
            .roundedRectangle(cornerRadius: 20),
            borderColor: .gray200,
            borderWidth: 1
        )
        .padding(.horizontal, 16.adjustedWidth)
        .padding(.bottom, 40.adjustedHeight)
    }
}

// MARK: - Preview

#Preview {
    PlaceInformationView(
        primaryTag: .cafe,
        placeName: "빈티지 카페 마망",
        introduction: "감성 가득한 빈티지 소품과 함께하는 공간",
        imageURLs: [
            "https://example.com/image1.jpg",
            "https://example.com/image2.jpg"
        ],
        address: "서울 마포구 망원로 42",
        contactNumber: "02-1234-5678",
        openingHours: "매일 11:00 - 22:00",
        snsLink: [
            PlaceDetailSnsLink(
                snsPlatform: "Instagram",
                url: "https://instagram.com/mamang_vintage"
            )
        ],
        copyAction: { copiedText in
            print("📋 복사됨: \(copiedText)")
        }
    )
}
