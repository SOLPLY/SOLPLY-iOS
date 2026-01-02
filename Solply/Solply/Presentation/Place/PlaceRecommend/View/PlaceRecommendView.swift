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
    
    @Binding private var scrollToTopTarget: ScrollToTopTarget?
    
    private let title: String
    private let townName: String
    private let isUserInformationLoading: Bool
    
    private let topId: String = "TOP"
    
    // MARK: - Initializer
    
    init(
        title: String,
        townName: String,
        isUserInformationLoading: Bool,
        scrollToTopTarget: Binding<ScrollToTopTarget?>
    ) {
        self.title = title
        self.townName = townName
        self.isUserInformationLoading = isUserInformationLoading
        self._scrollToTopTarget = scrollToTopTarget
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                scrollToTop
                
                VStack(alignment: .center, spacing: 28.adjustedHeight) {
                    placeRecommendTitle
                    
                    todayPlaceRecommendCarousel
                    
                    filterPlaceGrid
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 112.adjustedHeight)
            }
            .onChange(of: scrollToTopTarget) { _, target in
                guard target == .placeTopTarget else { return }
                
                withAnimation(.easeInOut(duration: 0.4)) {
                    proxy.scrollTo(topId, anchor: .top)
                }
                
                scrollToTopTarget = nil
            }
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

// MARK: - SubViews

extension PlaceRecommendView {
    private var scrollToTop: some View {
        Color.clear
            .frame(height: 0)
            .id(topId)
    }
    
    private var placeRecommendTitle: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(title)
                .applySolplyFont(.display_20_sb)
                .foregroundStyle(.coreBlack)
            
            Spacer()
        }
        .customLoading(.recommendTitleLoading, isLoading: isUserInformationLoading)
        .padding(.horizontal, 20.adjustedWidth)
    }
    
    private var todayPlaceRecommendCarousel: some View {
        TodayPlaceRecommendCarousel(store: store, townId: appState.townId)
            .customLoading(.todayPlaceRecommendCarouselLoading, isLoading: store.state.isCarouselLoading)
    }
    
    private var filterPlaceGrid: some View {
        FilterPlaceGrid(store: store, townId: appState.townId)
            .padding(.horizontal, 16.adjustedWidth)
    }
}
