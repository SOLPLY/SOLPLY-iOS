//
//  CourseRecommendView.swift
//  Solply
//
//  Created by 김승원 on 6/28/25.
//

import SwiftUI

struct CourseRecommendView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var scrollToTopManager: ScrollToTopManager
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store = CourseRecommendStore()
    
    private let topId: String = "TOP"
    
    // MARK: - Body
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                scrollToTop
                
                VStack(alignment: .center, spacing: 28.adjustedHeight) {
                    courseRecommendTitle
                    
                    courseRecommendGrid
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 112.adjustedHeight)
            }
            .onChange(of: scrollToTopManager.target) { _, target in
                guard target == .course else { return }
                
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
                            fromContext: .courseList
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
        .onAppear {
            store.dispatch(.fetchCourseRecommend(townId: appState.townId))
        }
        .background(.gray100)
    }
}

// MARK: - SubViews

extension CourseRecommendView {
    private var scrollToTop: some View {
        Color.clear
            .frame(height: 0)
            .id(topId)
    }
    
    private var courseRecommendTitle: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(appState.courseRecommendTitle)
                .applySolplyFont(.display_20_sb)
                .foregroundStyle(.coreBlack)
            
            Spacer()
        }
        .customLoading(.recommendTitleLoading, isLoading: appState.isUserInformationLoading)
        .frame(width: 335.adjustedWidth)
    }
    
    private var courseRecommendGrid: some View {
        CourseRecommendGrid(store: store) { courseId in
            appCoordinator.navigate(
                to: .courseDetail(
                    townId: appState.townId,
                    courseId: courseId,
                    fromArchive: false
                )
            )
        }
        .customLoading(.courseRecommendGridLoading, isLoading: store.state.isCourseGridLoading)
    }
}
