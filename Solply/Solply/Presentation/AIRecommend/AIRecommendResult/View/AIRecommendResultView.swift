//
//  AIRecommendResultView.swift
//  Solply
//
//  Created by sun on 3/15/26.
//

import SwiftUI

struct AIRecommendResultView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store: AIRecommendResultStore
    
    // MARK: - Initializer
    
    init(prompt: String, cards: [AIRecommendCard]) {
        self._store = StateObject(wrappedValue: AIRecommendResultStore(prompt: prompt, cards: cards))
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                promptText
                
                if store.cards.isEmpty {
                    AIRecommendEmptyView()
                } else {
                    resultCountText
                    recommendList
                }
            }
        }
        .customNavigationBar(
            .backWithTitle(
                title: "AI 추천",
                backAction: { appCoordinator.goBack() }
            )
        )
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            store.dispatch(.fetchAIRecommendResults)
        }
    }
}

// MARK: - UI Components

private extension AIRecommendResultView {
    
    var promptText: some View {
        AIRecommendPromptText(
            prompt: store.prompt
        )
        .padding(.top, 8.adjustedHeight)
        .padding(.bottom, 16.adjustedHeight)
        .padding(.horizontal, 16.adjustedWidth)
    }
    
    var resultCountText: some View {
        Text("추천 결과 \(store.cards.count)개")
            .applySolplyFont(.button_14_m)
            .foregroundColor(.gray800)
            .padding(.top, 16.adjustedHeight)
            .padding(.leading, 24.adjustedWidth)
    }
    
    var recommendList: some View {
        LazyVStack(alignment: .leading, spacing: 24.adjustedHeight) {
            ForEach(Array(store.cards.enumerated()), id: \.element.id) { _, card in
                switch card {
                case .place(let item):
                    AIRecommendPlaceCard(
                        mainTag: item.mainTag,
                        placeName: item.placeName,
                        townName: item.townName,
                        tipText: item.tipText,
                        filters: item.filters,
                        thumbnailImageUrl: item.thumbnailImageUrl
                    )
                    .onTapGesture {
                        // TODO: 장소 카드 탭 시 장소 상세
                    }

                case .course(let item):
                    AIRecommendCourseCard(
                        courseTag: item.courseTagType,
                        courseName: item.courseName,
                        townName: item.townName,
                        tipText: item.tipText,
                        courseCounts: item.courseCounts,
                        thumbnailImageUrl: item.thumbnailImageUrl
                    )
                    .onTapGesture {
                        // TODO: 코스 카드 탭 시 코스 상세
                    }
                }
            }
        }
        .padding(.horizontal, 16.adjustedWidth)
        .padding(.top, 16.adjustedHeight)
        .padding(.bottom, 40.adjustedHeight)
    }
}
