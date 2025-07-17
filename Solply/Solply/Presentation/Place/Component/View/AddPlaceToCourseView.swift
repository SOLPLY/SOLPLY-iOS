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
    
    private let courses: [CourseArchiveDTO]
    
    private let selectedIndex: Int
    private let cardAction: ((Int) -> Void)?
    private let addAction: ((Int) -> Void)?
    private let backAction: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        courses: [CourseArchiveDTO],
        selectedIndex: Int,
        cardAction: ((Int) -> Void)? = nil,
        addAction: ((Int) -> Void)? = nil,
        backAction: (() -> Void)? = nil
    ) {
        self.courses = courses
        self.selectedIndex = selectedIndex
        self.cardAction = cardAction
        self.addAction = addAction
        self.backAction = backAction
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
                    withAnimation(.easeInOut(duration: 0.1)) {
                        backAction?()
                    }
                } label: {
                    Image(.backIconIos)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
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
                        
                    } label: {
                        Text("나만의 코스 수집하러 가기")
                            .foregroundStyle(.green800)
                            .applySolplyFont(.button_16_m)
                            .padding(.horizontal, 34.adjustedWidth)
                            .padding(.vertical, 21.5.adjustedHeight)
                            .background(.green300)
                            .capsuleClipped()
                    }
                    .buttonStyle(.plain)
                }
            } else {
                ZStack(alignment: .bottom) {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 13.adjustedHeight) {
                            ForEach(Array(courses.enumerated()), id: \.element.courseId) { index, course in
                                ZStack(alignment: .topTrailing) {
                                    CourseCard(
                                        isSaved: course.isBookmarked ?? false,
                                        courseName: course.courseName,
                                        imageUrl: course.thumbnailImage,
                                        courseCategory: course.mainTags,
                                        isSelected: true
                                    ) {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            cardAction?(selectedIndex == index ? -1 : index)
                                        }
                                    }
                                    .opacity((course.isActive ?? true) ? 1 : 0.3)

                                    
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
                    
                    if selectedIndex != -1 {
                        CTAMainButton(title: "이 코스에 추가할래요") {
                            addAction?(selectedIndex)
                        }
                        .padding(.horizontal, 20.adjustedWidth)
                        .safeAreaInset(edge: .bottom) {
                            Color.clear.frame(height: 16)
                        }
                    }
                }
            }
        }
    }
}
