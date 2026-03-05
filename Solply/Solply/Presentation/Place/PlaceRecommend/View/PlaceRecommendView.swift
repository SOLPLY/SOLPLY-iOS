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
    @EnvironmentObject private var alertManager: AlertManager
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store = PlaceRecommendStore()
    
    @Binding private var scrollToTopTarget: ScrollToTopTarget?
    
    private let title: String
    private let isUserInformationLoading: Bool
    
    private let topId: String = "TOP"
    
    // MARK: - Initializer
    
    init(
        title: String,
        isUserInformationLoading: Bool,
        scrollToTopTarget: Binding<ScrollToTopTarget?>
    ) {
        self.title = title
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
                filterTitle: appState.townName,
                filterAction: {
                    
                    AmplitudeManager.shared.track(
                        .viewTownList(
                            entryMode: AmplitudeEntryMode.from(appState.userSession),
                            fromContext: .placeList
                        )
                    )
                    
                    appCoordinator.navigate(to: .JGD)
                },
                settingAction: {
                    appCoordinator.navigate(to: .placeSearch)
                }
            )
        )
        .background(.gray100)
        .onAppear {
            if appState.userSession == .authenticated {
                store.dispatch(.fetchPlaceRecommend(townId: appState.townId))
            }
            
            store.dispatch(.fetchPlaceList(
                townId: appState.townId,
                isBookmarkSearch: false,
                mainTagId: store.state.selectedMainTag.parentId == 0 ? nil : store.state.selectedMainTag.parentId,
                subTagAIdList: [],
                subTagBIdList: []
            ))
        }
        .onChange(of: appState.townId) { _, newTownId in
            if appState.userSession == .authenticated {
                store.dispatch(.fetchPlaceRecommend(townId: newTownId))
            }
            
            store.dispatch(.resetTags)
            store.dispatch(.resetSubTags)
            
            store.dispatch(.fetchPlaceList(
                townId: newTownId,
                isBookmarkSearch: false,
                mainTagId: store.state.selectedMainTag.parentId == 0 ? nil : store.state.selectedMainTag.parentId,
                subTagAIdList: [],
                subTagBIdList: []
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
        .frame(width: 335.adjustedWidth)
    }
    
    private var todayPlaceRecommendCarousel: some View {
        Group {
            switch appState.userSession {
            case .explore:
                ExplorePlaceRecommendCarousel() {
                    AmplitudeManager.shared.track(.viewLoginRequiredAlert(entryMode: .guest, blockedAction: .todayRecommend))
                    
                    alertManager.showAlert(alertType: .authenticationRequired) {
                        AmplitudeManager.shared.track(.clickLoginCancel(entryMode: .guest, blockedAction: .todayRecommend))
                    } onConfirm: {
                        appCoordinator.changeRoot(to: .auth)
                    }
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
