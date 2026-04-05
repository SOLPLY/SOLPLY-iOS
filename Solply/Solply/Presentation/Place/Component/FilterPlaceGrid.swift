//
//  FilterPlaceGrid.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import SwiftUI

struct FilterPlaceGrid: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var appCoordinator: AppCoordinator
    @ObservedObject var store: PlaceRecommendStore
    
    private let townId: Int
        
    private let columns = [
        GridItem(.fixed(145.adjusted), spacing: 12.5.adjusted),
        GridItem(.fixed(145.adjusted))
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
                        store.dispatch(.updateMainTag)
                        store.dispatch(.toggleMainTagBottomSheet)
                        AmplitudeManager.shared.track(.viewPlaceFilter(townId: townId))
                    }
                    .sheet(
                        isPresented: Binding(
                            get: { store.state.isMainTagBottomSheetPresented },
                            set: { isPresented, selectedTag in
                                if !isPresented {
                                    let current = store.state.selectedMainTag
                                    let previous = store.state.previousMainTag
                                    
                                    AmplitudeManager.shared.track(
                                        .selectPlaceMainTag(
                                            mainTag: AmplitudeSelectedMainTag.from(current),
                                            townId: appState.townId,
                                            townName: appState.townName
                                        )
                                    )
                                    
                                    if current != previous {
                                        store.dispatch(.resetSubTags)
                                        store.dispatch(.fetchPlaceList(
                                            townId: townId,
                                            isBookmarkSearch: false,
                                            mainTagId: current.parentId == 0 ? nil : current.parentId,
                                            subTagAIdList: [],
                                            subTagBIdList: []
                                        ))
                                    }
                                    
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
                                        AmplitudeManager.shared.track(
                                            .viewPlaceOptionPanel(
                                                townId: appState.townId,
                                                townName: appState.townName,
                                                selectedMainTag: AmplitudeSelectedMainTag.from(store.state.selectedMainTag)
                                            )
                                        )
                                        
                                        store.dispatch(.dismissMainTagBottomSheet)
                                    }
                                }
                            )
                        )
                        .presentationDetents([.fraction(0.54)])
                        .presentationCornerRadius(20)
                    }
                    
                    FilterButton(
                        title: isSelectedEmpty ? "추가옵션" : filteredFirstTag,
                        selectedSubTagsCount: filteredCount
                    ) {
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
                            ),
                            confirmAction: { selectedTags in
                                let subTags = selectedTags.filter { $0.isSelected }.map { $0.name }
                                
                                AmplitudeManager.shared.track(
                                    .completePlaceFilter(
                                        selectedOptionTags: subTags.map { AmplitudeSelectedOptionTag.from($0) },
                                        optionTagCount: store.state.selectedSubTags.count,
                                        townId: appState.townId ,
                                        townName: appState.townName
                                    )
                                )
                                
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
                        )
                        .presentationDetents([.fraction(0.6)])
                        .presentationCornerRadius(20)
                    }
                }
                
                Group {
                    if !store.state.fetchedPlaceList.isEmpty {
                        LazyVGrid(columns: columns, spacing: 13.adjustedHeight) {
                            ForEach(store.state.fetchedPlaceList) { place in
                                PlaceCard(
                                    isSaved: place.isBookmarked,
                                    thumbnailUrl: place.thumbnailUrl,
                                    placeName: place.placeName,
                                    placeCategory: place.mainTag,
                                    isSelected: true,
                                    size: 145.adjusted
                                ) {
                                    appCoordinator.navigate(to: .placeDetail(
                                        townId: townId,
                                        placeId: place.placeId,
                                        fromSearch: false
                                    ))
                                }
                            }
                        }
                    } else {
                        Text("검색 결과가 없어요")
                            .applySolplyFont(.body_14_m)
                            .foregroundStyle(.gray700)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .frame(height: 40.adjustedHeight)
                    }
                }
                .customLoading(.placeRecommendGridLoading, isLoading: store.state.isPlaceGridLoading)
            }
            .onChange(of: store.state.selectedMainTag) { _, _ in
                store.dispatch(.resetSubTags)
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
