//
//  TodayPlaceRecommendCarousel.swift
//  Solply
//
//  Created by seozero on 7/14/25.
//

import SwiftUI

struct TodayPlaceRecommendCarousel: View {

    // MARK: - Properties

    @EnvironmentObject var appCoordinator: AppCoordinator
    @ObservedObject private var store: PlaceRecommendStore

    @State private var currentIndex: Int = 1
    @State private var dragOffset: CGFloat = 0

    private let townId: Int

    private let cardWidth: CGFloat = 240.adjustedWidth
    private let cardSpacing: CGFloat = 16.adjustedWidth
    private var cardOffset: CGFloat {
        cardWidth / 2 + cardSpacing + (cardWidth * 0.75) / 2
    }

    // MARK: - Initializer

    init(store: PlaceRecommendStore, townId: Int) {
        self.store = store
        self.townId = townId
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            if !store.state.placeRecommendItems.isEmpty {
                ForEach(-2...2, id: \.self) { offsetIndex in
                    let index =
                    (currentIndex + offsetIndex + store.state.placeRecommendItems.count)
                    % store.state.placeRecommendItems.count
                    let baseX = CGFloat(offsetIndex) * cardOffset
                    let totalOffset = baseX + dragOffset
                    
                    let distanceFromCenter = abs(totalOffset)
                    let scale = max(0.75, 1.0 - (distanceFromCenter / (cardOffset * 2)))
                    
                    TodayPlaceRecommendCard(
                        thumbnailImageUrl: store.state.placeRecommendItems[index].thumbnailUrl,
                        category: store.state.placeRecommendItems[index].category,
                        title: store.state.placeRecommendItems[index].title,
                        introduction: store.state.placeRecommendItems[index].introduction
                    ) {
                        appCoordinator.navigate(
                            to: .placeDetail(
                                townId: townId,
                                placeId: store.state.placeRecommendItems[index].id,
                                fromSearch: false
                            )
                        )
                    }
                    .frame(width: cardWidth, height: cardWidth)
                    .scaleEffect(scale)
                    .offset(x: totalOffset)
                }
            }
        }
        .frame(height: 240.adjustedHeight)
        .gesture(
            DragGesture()
                .onChanged { value in
                    dragOffset = value.translation.width
                }
                .onEnded { value in
                    let threshold: CGFloat = 50.adjustedWidth
                    var newIndex = currentIndex
                    var targetOffset: CGFloat = 0

                    if value.translation.width < -threshold {
                        newIndex = (currentIndex + 1) % store.state.placeRecommendItems.count
                        targetOffset = -cardOffset
                    } else if value.translation.width > threshold {
                        newIndex =
                            (currentIndex - 1 + store.state.placeRecommendItems.count)
                            % store.state.placeRecommendItems.count
                        targetOffset = cardOffset
                    }

                    withAnimation(.easeOut(duration: 0.2)) {
                        dragOffset = targetOffset
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        dragOffset = 0
                        currentIndex = newIndex
                    }
                }
        )

    }
}
