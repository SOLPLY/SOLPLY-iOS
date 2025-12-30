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
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store = CourseRecommendStore()
    
    private let title: String
    private let townName: String
    
    // MARK: - Initializer
    
    init(title: String, townName: String) {
        self.title = title
        self.townName = townName
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
                
                CourseRecommendGrid(store: store) { courseId in
                    appCoordinator.navigate(
                        to: .courseDetail(
                            townId: appState.townId,
                            courseId: courseId,
                            fromArchive: false
                        )
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 112.adjustedHeight)
        }
        .customNavigationBar(
            .recommend(
                isLoading: true, // 수정 필요
                filterTitle: townName,
                filterAction: {
                    appCoordinator.navigate(to: .JGD)
                },
                settingAction: {
                    appCoordinator.navigate(to: .placeSearch)
                }
            )
        )
        .onChange(of: appState.townId) { _, townId in
            store.dispatch(.fetchCourseRecommend(townId: townId))
        }
        .background(.gray100)
        .task {
            store.dispatch(.fetchCourseRecommend(townId: appState.townId))
        }
    }
}

