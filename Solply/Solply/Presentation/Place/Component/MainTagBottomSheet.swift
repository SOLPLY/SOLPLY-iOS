//
//  MainTagBottomSheet.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import SwiftUI

struct MainTagBottomSheet: View {
    
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
        VStack(alignment: .center, spacing: 20.adjustedHeight) {
            HStack(alignment: .center, spacing: 0) {
                Text("장소 유형")
                    .applySolplyFont(.title_18_sb)
                
                Spacer()
                
                Button {
                    isPresented = false
                } label: {
                    Image(.xIconSm)
                        .resizable()
                        .frame(width: 24.adjusted, height: 24.adjusted)
                        .buttonStyle(.plain)
                }
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 11.adjustedHeight) {
                    ForEach(MainTagType.allCases) { category in
                        CategoryListRow(
                            category: category,
                            isSelectedCategory: category == store.state.selectedMainTag
                        ) {
                            store.dispatch(.selectMainTag(category))
                            store.dispatch(.fetchSubTags(parentId: category.parentId))
                            isPresented = false
                        }
                        
                        Divider()
                            .foregroundStyle(.gray200)
                    }
                }
            }
        }
        .padding(.horizontal, 16.adjustedWidth)
        .padding(.top, 24.adjustedHeight)

    }
}

struct CategoryListRow: View {
    
    // MARK: - Properties
    
    private let category: MainTagType
    private let isSelectedCategory: Bool
    
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        category: MainTagType,
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
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                Text(category.title)
                    .applySolplyFont(.body_16_r)
                Spacer()
                Image(.selectIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20.adjustedWidth, height: 20.adjustedHeight)
                    .visible(isSelectedCategory ? true : false)
            }
            .foregroundStyle(.coreBlack)
            .buttonStyle(.plain)
        }
    }
}
