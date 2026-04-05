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
    @EnvironmentObject private var scrollToTopManager: ScrollToTopManager
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store = PlaceRecommendStore()
    
    private let topId: String = "TOP"
    
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
            .onChange(of: scrollToTopManager.target) { _, target in
                guard target == .place else { return }
                
                withAnimation(.easeInOut(duration: 0.4)) {
                    proxy.scrollTo(topId, anchor: .top)
                }
            }
        }
        .customNavigationBar(
            .townFilterWithSearch(
                filterTitle: appState.townName,
                isLoading: appState.isUserInformationLoading,
                filterAction: {
                    AmplitudeManager.shared.track(
                        .viewTownList(
                            entryMode: AmplitudeEntryMode.from(appState.userSession),
                            fromContext: .placeList
                        )
                    )
                    
                    appCoordinator.navigate(to: .JGD)
                },
                aiAction: {
                    appState.requireLoginWithAlert(
                        onAuthenticated: { appCoordinator.navigate(to: .aiRecommend) },
                        onExplore: { appCoordinator.changeRoot(to: .auth) }
                    )
                },
                searchAction: { appCoordinator.navigate(to: .placeSearch) }
            )
        )
        .background(.gray100)
        .onAppear {
            if appState.userSession == .authenticated {
                store.dispatch(.fetchPlaceRecommend(townId: appState.townId))
            }
            
            // TODO: - TownId가 바뀌면 reset하도록 하고, 그대로면 아래 로직 진행하도록 수정해야함.
//            store.dispatch(.resetTags)
//            store.dispatch(.resetSubTags)
            
            let subTagAIdList = store.state.selectedSubTags
                .filter { $0.tagType == "OPTION1" && $0.isSelected }
                .map { $0.id }
            
            let subTagBIdList = store.state.selectedSubTags
                .filter { $0.tagType == "OPTION2" && $0.isSelected }
                .map { $0.id }
            
            store.dispatch(.fetchPlaceList(
                townId: appState.townId,
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
            Text(appState.placeRecommendTitle)
                .applySolplyFont(.display_20_sb)
                .foregroundStyle(.coreBlack)
            
            Spacer()
        }
        .customLoading(.recommendTitleLoading, isLoading: appState.isUserInformationLoading)
        .frame(width: 335.adjustedWidth)
    }
    
    private var todayPlaceRecommendCarousel: some View {
        Group {
            switch appState.userSession {
            case .explore:
                ExplorePlaceRecommendCarousel() {
                    AmplitudeManager.shared.track(.viewLoginRequiredAlert(entryMode: .guest, blockedAction: .todayRecommend))
                    
                    AlertManager.shared.showAlert(
                        alertType: .authenticationRequired,
                        onCancel: { AmplitudeManager.shared.track(.clickLoginCancel(entryMode: .guest, blockedAction: .todayRecommend)) },
                        onConfirm: { appCoordinator.changeRoot(to: .auth) }
                    )
                }
            case .authenticated:
                TodayPlaceRecommendCarousel(store: store, townId: appState.townId)
                    .customLoading(.todayPlaceRecommendCarouselLoading, isLoading: store.state.isCarouselLoading)
            }
        }
    }
    
    private var filterPlaceGrid: some View {
        FilterPlaceGrid(store: store, townId: appState.townId)
            .frame(width: 343.adjustedWidth)
    }
}
