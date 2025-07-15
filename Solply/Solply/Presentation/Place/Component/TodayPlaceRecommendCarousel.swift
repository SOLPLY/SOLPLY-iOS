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

    @State private var currentIndex: Int = 1
    @State private var dragOffset: CGFloat = 0

    private let placeRecommendItems: [TempPlaceRecommendItem]
    private let cardWidth: CGFloat = 240.adjustedWidth
    private let cardSpacing: CGFloat = 16.adjustedWidth
    private var cardOffset: CGFloat {
        cardWidth / 2 + cardSpacing + (cardWidth * 0.75) / 2
    }
    
    // MARK: - Initializer
    
    init(placeRecommendItems: [TempPlaceRecommendItem]) {
        self.placeRecommendItems = placeRecommendItems
    }
    
    // MARK: - Body

    var body: some View {
        ZStack {
            ForEach(-2...2, id: \.self) { offsetIndex in
                let index = (currentIndex + offsetIndex + placeRecommendItems.count) % placeRecommendItems.count
                let baseX = CGFloat(offsetIndex) * cardOffset
                let totalOffset = baseX + dragOffset

                let distanceFromCenter = abs(totalOffset)
                let scale = max(0.75, 1.0 - (distanceFromCenter / (cardOffset * 2)))

                TodayPlaceRecommendCard(
                    // TODO: - .temp 이미지 변경하기
                    backgroundImage: .temp,
                    category: placeRecommendItems[index].category,
                    title: placeRecommendItems[index].title,
                    description: placeRecommendItems[index].description
                )
                .frame(width: cardWidth, height: cardWidth)
                .scaleEffect(scale)
                .offset(x: totalOffset)
                .onTapGesture {
                    appCoordinator.navigate(to: .placeDetail)
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
                        newIndex = (currentIndex + 1) % placeRecommendItems.count
                        targetOffset = -cardOffset
                    } else if value.translation.width > threshold {
                        newIndex = (currentIndex - 1 + placeRecommendItems.count) % placeRecommendItems.count
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
