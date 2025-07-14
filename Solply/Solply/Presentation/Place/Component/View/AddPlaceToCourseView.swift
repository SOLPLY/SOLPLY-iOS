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
        GridItem(.fixed(165.adjustedWidth)),
        GridItem(.fixed(165.adjustedWidth))
    ]
    
    private let selectedIndex: Int
    private let cardAction: ((Int) -> Void)?
    private let addAction: ((Int) -> Void)?
    private let backAction: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        selectedIndex: Int,
        cardAction: ((Int) -> Void)? = nil,
        addAction: ((Int) -> Void)? = nil,
        backAction: (() -> Void)? = nil
    ) {
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
        ZStack(alignment: .bottom) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 13.adjustedHeight) {
                    ForEach(0..<4) { index in
                        ZStack(alignment: .topTrailing) {
                            CourseCard(
                                isSaved: true,
                                title: "오감으로 수집하는 하루",
                                courseCategory: [.cafe, .shopping],
                                isSelected: true
                            ) {
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
                }
                .padding(.top, 10.adjustedHeight)
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
