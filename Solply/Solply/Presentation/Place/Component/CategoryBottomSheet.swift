//
//  CategoryBottomSheet.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import SwiftUI

struct CategoryBottomSheet: View {
    
    // MARK: - Properties
    
    private var store: PlaceRecommendStore
    
    @Binding var isPresented: Bool
    
    // MARK: - Initializer
    
    init(store: PlaceRecommendStore, isPresented: Binding<Bool>) {
        self.store = store
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
                        .buttonStyle(.plain)
                }
            }
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 11) {
                    ForEach(PlaceCategoryType.allCases) { category in
                        CategoryListRow(
                            category: category,
                            isSelectedCategory: category == store.state.selectedCategory
                        ) {
                            store.dispatch(.selectCategory(category))
                        }
                        
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
    
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        category: PlaceCategoryType,
        isSelectedCategory: Bool,
        action: (() -> Void)? = nil
    ) {
        self.category = category
        self.isSelectedCategory = isSelectedCategory
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        Button {
            action?()
        } label: {
            HStack(alignment: .center, spacing: 4.adjustedWidth) {
                Image(category.icon)
                    .resizable()
                    .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                Text(category.title)
                    .applySolplyFont(.body_16_r)
                Spacer()
                Image(.selectIcon)
                    .resizable()
                    .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                    .visible(isSelectedCategory ? true : false)
            }
            .foregroundStyle(.coreBlack)
            .buttonStyle(.plain)
        }
    }
}
