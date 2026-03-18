//
//  AIRecommendEmpty.swift
//  Solply
//
//  Created by sun on 3/17/26.
//

import SwiftUI

struct AIRecommendEmptyView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            promptText
            
            Spacer()
            
            emptyText
            
            Spacer()
            
            popularRecommendSection
        }
        .padding(.bottom, 24.adjustedHeight)
        .customNavigationBar(
            .backWithTitle(
                title: "AI 추천",
                backAction: { appCoordinator.goBack() }
            )
        )
    }
}

// MARK: - UI Components

private extension AIRecommendEmptyView {
    
    var promptText: some View {
        AIRecommendPromptText(
            prompt: "서버에서 값 가져오는 거겠지"
        )
        .padding(.top, 8.adjustedHeight)
        .padding(.horizontal, 16.adjustedWidth)
    }
    
    var emptyText: some View {
        Text("원하시는 장소를 찾지 못했어요")
            .applySolplyFont(.body_16_m)
            .foregroundStyle(.gray700)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
    }
    
    var popularRecommendSection: some View {
        PopularRecommend(
            popularPrompt: [
                "성수에서 작업하기 좋은 조용한 카페 추천해줘",
                "망원에서 혼자 오래 머물기 좋은 카페",
                "연남동 디저트가 맛있는 감성카페",
                "서촌 사색하기 좋은 책방"
            ]
        )
        .padding(.top, 24.adjustedHeight)
        .padding(.horizontal, 16.adjustedWidth)
    }
}
