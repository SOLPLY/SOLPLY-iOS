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
    @StateObject private var store = AIRecommendResultStore()
    
    var onChange: ((String) -> Void)?
    var onSubmit: ((String) -> Void)?
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                searchBar
                resultCountText
                recommendList
            }
        }
        .customNavigationBar(
            .backWithTitle(
                title: "AI 추천",
                backAction: { appCoordinator.goBack() }
            )
        )
        .onAppear {
            store.dispatch(.fetchAIRecommendResults)
        }
    }
}

// MARK: - UI Components

private extension AIRecommendResultView {
    
    var searchBar: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray100)
                .frame(height: 52.adjustedHeight)
                .addBorder(
                    .roundedRectangle(cornerRadius: 20),
                    borderColor: .gray300,
                    borderWidth: 1
                )
            
            HStack {
                Text("서버에서 값 가져오는 거겠지")
                    .applySolplyFont(.body_14_r)
                    .foregroundColor(.gray900)
                
                Spacer()
            }
            .padding(.horizontal, 20.adjustedWidth)
        }
        .padding(.bottom, 16.adjustedHeight)
        .padding(.horizontal, 16.adjustedWidth)
    }
    
    var resultCountText: some View {
        Text("추천 결과 \(store.state.cards.count)개")
            .applySolplyFont(.button_14_m)
            .foregroundColor(.gray800)
            .padding(.top, 16.adjustedHeight)
            .padding(.leading, 24.adjustedWidth)
    }
    
    var recommendList: some View {
        LazyVStack(alignment: .leading, spacing: 24.adjustedHeight) {
            ForEach(store.state.cards, id: \.id) { card in
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
                        store.dispatch(.selectPlaceCard(item: item))
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
                        store.dispatch(.selectCourseCard(item: item))
                    }
                }
            }
        }
        .padding(.horizontal, 16.adjustedWidth)
        .padding(.top, 16.adjustedHeight)
        .padding(.bottom, 24.adjustedHeight)
    }
}
