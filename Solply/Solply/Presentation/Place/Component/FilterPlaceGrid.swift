//
//  FilterPlaceGrid.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import SwiftUI

struct FilterPlaceGrid: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    @ObservedObject var store: PlaceRecommendStore
    
    private let townId: Int
        
    private let columns = [
        GridItem(.fixed(145.adjustedWidth), spacing: 12.5.adjustedWidth),
        GridItem(.fixed(145.adjustedWidth))
    ]
    
    private var filteredCount: Int {
        store.state.selectedSubTags.count
    }

    private var filteredFirstTag: String {
        store.state.selectedSubTags.first?.name.title ?? ""
    }

    private var isSelectedEmpty: Bool {
        store.state.selectedSubTags.isEmpty
    }
    
    private var mainTag: MainTagType {
        store.state.selectedMainTag
    }
    
    init(store: PlaceRecommendStore, townId: Int) {
        self.store = store
        self.townId = townId
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 20)
                .fill(.coreWhite)
            
            VStack(alignment: .leading, spacing: 16.adjustedHeight) {
                HStack(alignment: .center, spacing: 8.adjustedWidth) {
                    FilterButton(title: mainTag.title) {
                        store.dispatch(.toggleMainTagBottomSheet)
                    }
                    .sheet(
                        isPresented: Binding(
                            get: { store.state.isMainTagBottomSheetPresented },
                            set: { isPresented, selectedTag in
                                if !isPresented {
                                    store.dispatch(.resetSubTags)
                                    store.dispatch(.fetchPlaceList(
                                        townId: townId,
                                        isBookmarkSearch: false,
                                        mainTagId: store.state.selectedMainTag.parentId == 0 ? nil : store.state.selectedMainTag.parentId,
                                        subTagAIdList: [],
                                        subTagBIdList: []
                                    ))
                                    store.dispatch(.dismissMainTagBottomSheet)
                                }
                            }
                        )
                    ) {
                        MainTagBottomSheet(
                            store: store,
                            isPresented: Binding(
                                get: { store.state.isMainTagBottomSheetPresented },
                                set: { isPresented in
                                    if !isPresented {
                                        store.dispatch(.dismissMainTagBottomSheet)
                                    }
                                }
                            )
                        )
                            .presentationDetents([.fraction(0.54)])
                    }
                    
                    FilterButton(title: isSelectedEmpty ? "추가옵션" : (filteredCount > 1 ? "\(filteredFirstTag) 외 \(filteredCount - 1)개" : "\(filteredFirstTag)")) {
                        store.dispatch(.toggleSubTagBottomSheet)
                    }
                    .visible(
                        store.state.fetchedSubTags.isEmpty || mainTag == .all ? false : true
                    )
                    .sheet(
                        isPresented: Binding(
                            get: { store.state.isSubTagBottomSheetPresented },
                            set: { isPresented in
                                if !isPresented {
                                    store.dispatch(.dismissSubTagBottomSheet)
                                }
                            }
                        )
                    ) {
                        SubTagBottomSheet(
                            store: store,
                            isPresented: Binding(
                                get: { store.state.isSubTagBottomSheetPresented },
                                set: { isPresented in
                                    if !isPresented {
                                        store.dispatch(.dismissSubTagBottomSheet)
                                    }
                                }
                            )
                        ) { selectedTags in
                            store.dispatch(.updateSubTags(selectedTags))
                            
                            let subTagAIdList = selectedTags
                                .filter { $0.tagType == "OPTION1" && $0.isSelected }
                                .map { $0.id }
                            
                            let subTagBIdList = selectedTags
                                .filter { $0.tagType == "OPTION2" && $0.isSelected }
                                .map { $0.id }
                            
                            store.dispatch(.fetchPlaceList(
                                townId: townId,
                                isBookmarkSearch: false,
                                mainTagId: store.state.selectedMainTag.parentId,
                                subTagAIdList: subTagAIdList,
                                subTagBIdList: subTagBIdList
                            ))
                        }
                            .presentationDetents([.fraction(0.6)])
                    }
                }
                
                LazyVGrid(columns: columns, spacing: 13.adjustedHeight) {
                    ForEach(store.state.fetchedPlaceList) { place in
                        PlaceCard(
                            isSaved: place.isBookmarked,
                            thumbnailUrl: place.thumbnailUrl,
                            placeName: place.placeName,
                            placeCategory: place.mainTag,
                            isSelected: true,
                            size: 145
                        ) {
                            appCoordinator.navigate(to: .placeDetail(
                                townId: townId,
                                placeId: place.placeId
                            ))
                        }
                    }
                }
            }
            .onChange(of: store.state.selectedMainTag) { _, _ in
                store.dispatch(.resetSubTags)
            }
            .onChange(of: townId) { _, _ in
                
                store.dispatch(.fetchSubTags(
                    parentId: store.state.selectedMainTag.parentId
                ))
                
                let subTagAIdList = store.state.fetchedSubTags
                    .filter { $0.tagType == "OPTION1" }
                    .map { $0.id }
                
                let subTagBIdList = store.state.fetchedSubTags
                    .filter { $0.tagType == "OPTION2" }
                    .map { $0.id }
                
                store.dispatch(.fetchPlaceList(
                    townId: townId,
                    isBookmarkSearch: false,
                    mainTagId: store.state.selectedMainTag.parentId == 0 ? nil : store.state.selectedMainTag.parentId,
                    subTagAIdList: subTagAIdList,
                    subTagBIdList: subTagBIdList
                ))
            }
            .padding(.vertical, 20.adjustedHeight)
            .padding(.horizontal, 20.adjustedWidth)
        }
    }
}

extension FilterPlaceGrid {
    private func isSameSelection(_ new: [SelectableSubTag], _ old: [SelectableSubTag]) -> Bool {
        let newSelected = new.filter { $0.isSelected }.map { $0.id }.sorted()
        let oldSelected = old.filter { $0.isSelected }.map { $0.id }.sorted()
        return newSelected == oldSelected
    }
}
