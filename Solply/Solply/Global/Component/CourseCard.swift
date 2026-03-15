//
//  CourseCard.swift
//  Solply
//
//  Created by LEESOOYONG on 7/8/25.
//

//
//  CourseCard.swift
//  Solply
//
//  Created by LEESOOYONG on 7/8/25.
//

import SwiftUI

import Kingfisher

struct CourseCard: View {
    
    // MARK: - Properties
    
    private let isSaved: Bool
    private let courseName: String
    private let imageUrl: String?
    private let courseTagType: CourseTagType
    private let isChecked: Bool
    private let isActive: Bool
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        isSaved: Bool,
        courseName: String,
        imageUrl: String?,
        courseTagType: CourseTagType,
        isChecked: Bool = false,
        isActive: Bool = true,
        action: (() -> Void)? = nil
    ) {
        self.isSaved = isSaved
        self.courseName = courseName
        self.imageUrl = imageUrl
        self.courseTagType = courseTagType
        self.isChecked = isChecked
        self.isActive = isActive
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottom) {
                courseThumnail
                
                cardShellShadow
                
                cardShell
            }
            
            if !isActive {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.coreWhite)
                    .opacity(0.7)
            }
            
            if isChecked {
                Image(.checkIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 36.adjustedWidth, height: 36.adjustedHeight)
                    .padding(.top, 12.adjustedHeight)
                    .padding(.trailing, 12.adjustedWidth)
            }
        }
        .frame(width: 165.adjusted, height: 165.adjusted)
        .cornerRadius(20, corners: .allCorners)
        .contentShape(Rectangle())
        .onTapGesture {
            action?()
        }
    }
}

// MARK: - Subviews

extension CourseCard {
    private var courseThumnail: some View {
        ThumbnailImage(
            imageUrl,
            width: 165.adjusted,
            height: 165.adjusted,
            radius: 0
        )
    }
    
    private var cardShellShadow: some View {
        Rectangle()
            .frame(width: 165.adjusted, height: 93.adjusted)
            .foregroundStyle(.coreBlackO20)
            .cornerRadius(4, corners: [.topLeft, .topRight])
    }
    
    private var cardShell: some View {
        VStack(alignment: .leading, spacing: 12.adjusted) {
            HStack(alignment: .top, spacing: 0) {
                Text(courseName)
                    .applySolplyFont(.title_14_m)
                    .foregroundStyle(.coreBlack)
                    .frame(height: 38.adjusted, alignment: .topLeading)
                    .padding(.top, 8.adjusted)
                
                Spacer()
                
                if isSaved {
                    Image(courseTagType.savedBadge)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24.adjusted, height: 32.adjusted)
                }
            }
            .padding(.horizontal, 12.adjusted)
            
            cardShellMainTags
        }
        .frame(width: 165.adjusted, height: 88.adjusted)
        .background(courseTagType.backgroundColor)
        .cornerRadius(4, corners: [.topLeft, .topRight])
    }
    
    private var cardShellMainTags: some View {
        CourseCategoryTag(courseTagType: courseTagType)
            .padding(.bottom, 12.adjusted)
            .padding(.leading, 12.adjusted)
    }
}
