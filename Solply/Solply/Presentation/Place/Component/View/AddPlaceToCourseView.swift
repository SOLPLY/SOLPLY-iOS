//
//  AddPlaceToCourseView.swift
//  Solply
//
//  Created by 김승원 on 7/14/25.
//

import SwiftUI

struct AddPlaceToCourseView: View {
    
    // MARK: - Properties
    
    private let columns = [
        GridItem(.fixed(165.adjustedWidth), spacing: 11.adjustedWidth),
        GridItem(.fixed(165.adjustedWidth))
    ]
    
    private let courses: [AddToCourseArchive]
    
    private let selectedIndex: Int
    private let cardAction: ((Int) -> Void)?
    private let backAction: (() -> Void)?
    private let goToAddCourseAction: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        courses: [AddToCourseArchive],
        selectedIndex: Int,
        cardAction: ((Int) -> Void)? = nil,
        backAction: (() -> Void)? = nil,
        goToAddCourseAction: (() -> Void)? = nil
    ) {
        self.courses = courses
        self.selectedIndex = selectedIndex
        self.cardAction = cardAction
        self.backAction = backAction
        self.goToAddCourseAction = goToAddCourseAction
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 10.adjustedHeight) {
            navigationBar
            
            courseGrid
            
            Spacer()
        }
    }
}

extension AddPlaceToCourseView {
    private var navigationBar: some View {
        ZStack(alignment: .center) {
            HStack(alignment: .center, spacing: 0) {
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        backAction?()
                    }
                } label: {
                    Image(.backIconIos)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24.adjusted, height: 24.adjusted)
                }
                .buttonStyle(.plain)
                
                Spacer()
            }
            
            Text("내 코스에 추가")
                .applySolplyFont(.head_16_m)
                .foregroundStyle(.coreBlack)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16.adjustedWidth)
    }
    
    private var courseGrid: some View {
        Group {
            if courses.isEmpty {
                VStack(alignment: .center, spacing: 28.adjustedHeight) {
                    Text("저장된 코스가 없어요.")
                        .applySolplyFont(.body_16_m)
                        .foregroundStyle(.gray800)
                        .padding(.top, 130.adjustedHeight)
                    
                    Button {
                        goToAddCourseAction?()
                    } label: {
                        Text("나만의 코스 수집하러 가기")
                            .foregroundStyle(.green800)
                            .applySolplyFont(.button_16_m)
                            .padding(.horizontal, 34.adjustedWidth)
                            .padding(.vertical, 17.5.adjustedHeight)
                            .background(.green300)
                            .capsuleClipped()
                    }
                    .buttonStyle(.plain)
                }
            } else {
                ZStack(alignment: .bottom) {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 13.adjustedHeight) {
                            ForEach(Array(courses.enumerated()), id: \.offset) { index, course in
                                ZStack(alignment: .topTrailing) {
                                    CourseCard(
                                        isSaved: course.isBookmarked ?? false,
                                        courseName: course.courseName,
                                        imageUrl: course.thumbnailImage,
                                        courseTagType: course.courseTag,
                                        isSelected: true
                                    ) {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            cardAction?(selectedIndex == index ? -1 : index)
                                        }
                                    }
                                    
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundStyle(.coreWhite)
                                        .opacity((course.isActive ?? true) ? 0 : 0.7)
                                        .onTapGesture {
                                            withAnimation(.easeInOut(duration: 0.2)) {
                                                cardAction?(selectedIndex == index ? -1 : index)
                                            }
                                        }
                                    
                                    if selectedIndex == index {
                                        Image(.checkIcon)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 36.adjustedWidth, height: 36.adjustedHeight)
                                            .padding(.top, 12.adjustedHeight)
                                            .padding(.trailing, 12.adjustedWidth)
                                    }
                                }
                            }
                            .padding(.top, 10.adjustedHeight)
                            
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}
