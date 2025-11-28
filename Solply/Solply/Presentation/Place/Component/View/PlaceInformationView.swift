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
    private let isBookmarked: Bool
    private let introduction: String
    private let imageURLs: [String]
    private let address: String
    private let contactNumber: String
    private let openingHours: String
    private let snsLink: [PlaceDetailSnsLink]
    private let bookmarkAction: (() -> Void)?
    private let findDirectionAction: (() -> Void)?
    private let addPlaceToCourseAction: (() -> Void)?
    private let copyAction: ((String) -> Void)?
    private let reportsAction: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        primaryTag: MainTagType,
        placeName: String,
        isBookmarked: Bool,
        introduction: String,
        imageURLs: [String],
        address: String,
        contactNumber: String,
        openingHours: String,
        snsLink: [PlaceDetailSnsLink],
        bookmarkAction: (() -> Void)? = nil,
        findDirectionAction: (() -> Void)? = nil,
        addPlaceToCourseAction: (() -> Void)? = nil,
        copyAction: ((String) -> Void)? = nil,
        reportsAction: (() -> Void)? = nil
    ) {
        self.primaryTag = primaryTag
        self.placeName = placeName
        self.isBookmarked = isBookmarked
        self.introduction = introduction
        self.imageURLs = imageURLs
        self.address = address
        self.contactNumber = contactNumber
        self.openingHours = openingHours
        self.snsLink = snsLink
        self.bookmarkAction = bookmarkAction
        self.findDirectionAction = findDirectionAction
        self.addPlaceToCourseAction = addPlaceToCourseAction
        self.copyAction = copyAction
        self.reportsAction = reportsAction
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 22.adjustedHeight) {
            title
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20.adjustedHeight) {
                    HStack(alignment: .center, spacing: 8.adjustedWidth) {
                        findDirectionButton
                        
                        addPlaceToCourseButton
                    }
                    .padding(.top, 1.adjustedHeight)
                    .padding(.horizontal, 16.adjustedWidth)
                    
                    mainImage
                    
                    information
                    
                    reportsButton
                }
                .padding(.bottom, 85.adjustedHeight)
            }
            .frame(maxHeight: .infinity)
        }
    }
}

// MARK: - Subviews

extension PlaceInformationView {
    private var title: some View {
        VStack(alignment: .leading, spacing: 8.adjustedHeight) {
            HStack(alignment: .center, spacing: 8.adjustedWidth) {
                PlaceCategoryTag(placeCategory: primaryTag)
                
                Text(placeName)
                    .applySolplyFont(.title_18_sb)
                    .foregroundStyle(.coreBlack)
                    .frame(height: 23.adjustedHeight)
                
                Spacer()
                
                Button {
                    bookmarkAction?()
                } label: {
                    Image(isBookmarked ? .bookmarkSavedIcon : .bookmarkIcon)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.gray900)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28.adjusted, height: 28.adjusted)
                }
                .buttonStyle(.plain)
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
                        .placeholder {
                            Image(.placedetailPlaceholder)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 307.adjustedWidth, height: 204.adjustedHeight)
                        .background(.gray200)
                        .cornerRadius(12, corners: .allCorners)
                }
            }
            .padding(.horizontal, 16.adjustedWidth)
        }
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
    }
    
    private var findDirectionButton: some View {
        Button {
            findDirectionAction?()
        } label: {
            HStack(alignment: .center, spacing: 0) {
                Text("길찾기")
                    .applySolplyFont(.button_14_m)
                    .foregroundStyle(.gray800)
                
                Image(.tolinkIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20.adjusted, height: 20.adjusted)
            }
            .frame(width: 57.adjustedWidth, height: 24.adjustedHeight)
            .padding(.vertical, 8.adjustedHeight)
            .padding(.leading, 16.adjustedWidth)
            .padding(.trailing, 12.adjustedWidth)
            .background(.gray100)
            .capsuleClipped()
            .addBorder(.capsule, borderColor: .gray300, borderWidth: 1)
        }
        .buttonStyle(.plain)
    }
    
    private var addPlaceToCourseButton: some View {
        Button {
            addPlaceToCourseAction?()
        } label: {
            Text("내 코스에 추가")
                .applySolplyFont(.button_14_m)
                .foregroundStyle(.coreWhite)
                .frame(width: 80.adjustedWidth, height: 24.adjustedHeight)
                .padding(.vertical, 8.adjustedHeight)
                .padding(.horizontal, 16.adjustedWidth)
                .background(.gray900)
                .capsuleClipped()
        }
        .buttonStyle(.plain)
    }
    
    private var reportsButton: some View {
        HStack(alignment: .center, spacing: 4.adjustedWidth) {
            Image(.warningIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24.adjusted, height: 24.adjusted)
            
            Text("잘못된 정보가 있어요.")
                .applySolplyFont(.body_14_r)
                .foregroundStyle(.gray800)
            
            Spacer()
            
            Button {
                reportsAction?()
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    Text("오류 제보하기")
                        .applySolplyFont(.button_14_m)
                        .foregroundStyle(.red600)
                    
                    Image(.arrowRightIcon)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.red600)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24.adjusted, height: 24.adjusted)
                }
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.vertical, 12.adjustedHeight)
        .addBorder(
            .roundedRectangle(cornerRadius: 20),
            borderColor: .gray200,
            borderWidth: 1
        )
        .padding(.horizontal, 16.adjustedWidth)
    }
}

// MARK: - Preview

#Preview {
    PlaceInformationView(
        primaryTag: .cafe,
        placeName: "빈티지 카페 마망",
        isBookmarked: true,
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
