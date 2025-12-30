//
//  PlaceView.swift
//  Solply
//
//  Created by 김승원 on 6/28/25.
//

import SwiftUI

struct PlaceRecommendView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store = PlaceRecommendStore()
    
    private let title: String
    private let townName: String
    private let isUserInformationLoading: Bool
    
    // MARK: - Initializer
    
    init(title: String, townName: String, isUserInformationLoading: Bool) {
        self.title = title
        self.townName = townName
        self.isUserInformationLoading = isUserInformationLoading
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 28.adjustedHeight) {
                HStack(alignment: .center, spacing: 0) {
                    Text(title)
                        .applySolplyFont(.display_20_sb)
                        .foregroundStyle(.coreBlack)
                    
                    Spacer()
                }
                .customLoading(.recommendTitleLoading, isLoading: isUserInformationLoading)
                .padding(.horizontal, 20.adjustedWidth)
                
                TodayPlaceRecommendCarousel(store: store, townId: appState.townId)
                
                FilterPlaceGrid(store: store, townId: appState.townId)
                    .padding(.horizontal, 16.adjustedWidth)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 112.adjustedHeight)
        }
        .customNavigationBar(
            .recommend(
                isLoading: isUserInformationLoading,
                filterTitle: townName,
                filterAction: {
                    appCoordinator.navigate(to: .JGD)
                },
                settingAction: {
                    appCoordinator.navigate(to: .placeSearch)
                }
            )
        )
        .background(.gray100)
        .onAppear {
            store.dispatch(.fetchPlaceRecommend(townId: appState.townId))
            store.dispatch(.fetchPlaceList(
                townId: appState.townId,
                isBookmarkSearch: false,
                mainTagId: store.state.selectedMainTag.parentId == 0 ? nil : store.state.selectedMainTag.parentId,
                subTagAIdList: [],
                subTagBIdList: []
            ))
        }
        .onChange(of: appState.townId) { _, newTownId in
            store.dispatch(.fetchPlaceRecommend(townId: newTownId))
            store.dispatch(.resetTags)
            
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
