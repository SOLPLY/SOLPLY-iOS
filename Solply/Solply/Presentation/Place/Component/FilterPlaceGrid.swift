//
//  FilterPlaceGrid.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import SwiftUI

struct FilterPlaceGrid: View {
    
    // MARK: - Properties
    
    @StateObject private var store = PlaceRecommendStore()
    
    @State private var selectedOptionTags: [SelectableOptionTag] = []
    
    private let columns = [
        GridItem(.fixed(145.adjustedWidth), spacing: 12.5.adjustedWidth),
        GridItem(.fixed(145.adjustedWidth))
    ]
    
    private var filteredCount: Int {
        selectedOptionTags.count
    }

    private var filteredFirstTag: String {
        selectedOptionTags.first?.name ?? ""
    }

    private var isSelected: Bool {
        !selectedOptionTags.isEmpty
    }
    
    private var placeCategory: PlaceCategoryType {
        store.state.selectedCategory
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 20)
                .fill(.coreWhite)
            
            VStack(alignment: .leading, spacing: 16.adjustedHeight) {
                HStack(alignment: .center, spacing: 8.adjustedWidth) {
                    FilterButton(title: placeCategory.title) {
                        store.dispatch(.toggleCategoryBottomSheet)
                    }
                    .sheet(
                        isPresented: Binding(
                            get: { store.state.isCategoryBottomSheetPresented },
                            set: { isPresented in
                                if !isPresented {
                                    store.dispatch(.dismissCategoryBottomSheet)
                                }
                            }
                        )
                    ) {
                        CategoryBottomSheet(
                            store: store,
                            isPresented: Binding(
                                get: { store.state.isCategoryBottomSheetPresented },
                                set: { isPresented in
                                    if !isPresented {
                                        store.dispatch(.dismissCategoryBottomSheet)
                                    }
                                }
                            )
                        )
                            .presentationDetents([.fraction(0.54)])
                    }
                    
                    FilterButton(title: isSelected ? "\(filteredFirstTag) 외 \(filteredCount - 1)개" : "추가옵션") {
                        store.dispatch(.toggleMoreOptionBottomSheet)
                    }
                    .visible(placeCategory == .all ? false : true)
                    .sheet(
                        isPresented: Binding(
                            get: { store.state.isMoreOptionBottomSheetPresented },
                            set: { isPresented in
                                if !isPresented {
                                    store.dispatch(.dismissMoreOptionBottomSheet)
                                }
                            }
                        )
                    ) {
                        MoreOptionBottomSheet(
                            isPresented: Binding(
                                get: { store.state.isMoreOptionBottomSheetPresented },
                                set: { isPresented in
                                    if !isPresented {
                                        store.dispatch(.dismissMoreOptionBottomSheet)
                                    }
                                }
                            )
                        ) { selectedTags in
                            self.selectedOptionTags = selectedTags
                        }
                            .presentationDetents([.fraction(0.6)])
                    }
                }
                
                LazyVGrid(columns: columns, spacing: 13.adjustedHeight) {
                    ForEach(0..<10) { index in
                        PlaceCard(
                            isSaved: true,
                            title: "유어마인드",
                            placeCategory: .shopping,
                            isSelected: true,
                            size: 145
                        ) {
                            print("gg")
                        }
                    }
                }
            }
            .padding(.vertical, 20.adjustedHeight)
            .padding(.horizontal, 20.adjustedWidth)
        }
    }
}
