//
//  CategoryBottomSheet.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import SwiftUI

struct CategoryBottomSheet: View {
    
    // MARK: - Properties
    
    private var state: PlaceRecommendState
    
    @Binding var isPresented: Bool
    
    // MARK: - Initializer
    
    init(state: PlaceRecommendState, isPresented: Binding<Bool>) {
        self.state = state
        self._isPresented = isPresented
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack(alignment: .center, spacing: 0) {
                Text("장소 유형")
                    .applySolplyFont(.title_18_sb)
                
                Spacer()
                
                Button {
                    isPresented = false
                } label: {
                    Image(.xIconSm)
                        .resizable()
                        .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                }
            }
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 11) {
                    ForEach(PlaceCategoryType.allCases) { category in
                        CategoryListRow(
                            category: category,
                            isSelectedCategory: category == state.selectedCategory
                        )
                        
                        Divider()
                            .foregroundStyle(.gray200)
                    }
                }
            }
            // UI상, ScrollView로 감싸주었고 스크롤은 굳이 필요하지 않아서 disable로 설정해둠.
            .scrollDisabled(true)
        }
        .padding(.horizontal, 16.adjustedWidth)
        .padding(.top, 24.adjustedHeight)

    }
}

struct CategoryListRow: View {
    
    // MARK: - Properties
    
    private let category: PlaceCategoryType
    private let isSelectedCategory: Bool
    
    // MARK: - Initializer
    
    init(category: PlaceCategoryType, isSelectedCategory: Bool) {
        self.category = category
        self.isSelectedCategory = isSelectedCategory
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            Image(category.icon)
                .resizable()
                .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
            Text(category.title)
                .applySolplyFont(.body_16_r)
            Spacer()
            Image(.checkIcon)
                .resizable()
                .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                .visible(isSelectedCategory ? true : false)
        }
    }
}
