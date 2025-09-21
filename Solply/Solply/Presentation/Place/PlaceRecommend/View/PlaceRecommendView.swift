//
//  PlaceView.swift
//  Solply
//
//  Created by 김승원 on 6/28/25.
//

import SwiftUI

struct PlaceRecommendView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject private var store = PlaceRecommendStore()
    
    @Binding var townId: Int
    
    private let title: String
    private let townName: String
    
    // MARK: - Initializer
    
    init(
        title: String,
        townName: String,
        townId: Binding<Int>
    ) {
        self.title = title
        self.townName = townName
        self._townId = townId
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 28.adjustedHeight) {
                HStack(alignment: .center, spacing: 0) {
                    Text(title)
                        .applySolplyFont(.display_20_sb)
                    Spacer()
                }
                .padding(.horizontal, 20.adjustedWidth)
                
                if !store.state.placeRecommendItems.isEmpty {
                    TodayPlaceRecommendCarousel(store: store, townId: townId)
                }
                
                FilterPlaceGrid(store: store, townId: townId)
                    .padding(.horizontal, 16.adjustedWidth)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 112.adjustedHeight)
        }
        .customNavigationBar(.recommend(
            filterTitle: townName,
            filterAction: {
                appCoordinator.navigate(to: .frequentTown)
            },
            settingAction: {
                appCoordinator.navigate(to: .placeSearch)
            }
        ))
        .background(.gray100)
        .onAppear {
            store.dispatch(.fetchPlaceRecommend(townId: townId))
            store.dispatch(.fetchPlaceList(
                townId: townId,
                isBookmarkSearch: false,
                mainTagId: store.state.selectedMainTag.parentId == 0 ? nil : store.state.selectedMainTag.parentId,
                subTagAIdList: [],
                subTagBIdList: []
            ))
        }
        .onChange(of: townId) { _, newTownId in
            store.dispatch(.fetchPlaceRecommend(townId: newTownId))
            
            let subTagAIdList = store.state.selectedSubTags
                .filter { $0.tagType == "OPTION1" && $0.isSelected }
                .map { $0.id }
            
            let subTagBIdList = store.state.selectedSubTags
                .filter { $0.tagType == "OPTION2" && $0.isSelected }
                .map { $0.id }
            
            store.dispatch(.fetchPlaceList(
                townId: newTownId,
                isBookmarkSearch: false,
                mainTagId: store.state.selectedMainTag.parentId == 0 ? nil : store.state.selectedMainTag.parentId,
                subTagAIdList: subTagAIdList,
                subTagBIdList: subTagBIdList
            ))
        }
    }
}
