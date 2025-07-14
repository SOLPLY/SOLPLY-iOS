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
    
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(action: (() -> Void)? = nil) {
        self.action = action
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
                    action?()
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
        ScrollView {
            LazyVGrid(columns: columns, spacing: 13.adjustedHeight) {
                ForEach(0..<4) { index in
                    CourseCard(
                        isSaved: true,
                        title: "오감으로 수집하는 하루",
                        courseCategory: [.cafe, .shopping],
                        isSelected: true
                    ) {
                        // TODO: 코스 저장
                    }
                }
            }
            .padding(.top, 10.adjustedHeight)
        }
    }
}
