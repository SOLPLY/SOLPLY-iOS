//
//  AIRecommendPromptView.swift
//  Solply
//
//  Created by seozero on 3/14/26.
//

import SwiftUI

struct AIRecommendPromptView: View {
    
    @StateObject private var store = AIRecommendPromptStore()
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            aiRecommendBar
            
            townSelectWithGuide
            
            aiRecommendPromptField
            
            popularRecommend
            
            aiRecommendButton
        }
        .customNavigationBar(.backWithTitle(title: "AI 추천") {
            
        })
    }
}

extension AIRecommendPromptView {
    private var aiRecommendBar: some View {
        AIRecommendBar(
            selectedCategory: store.state.selectedCategory,
            action: { selectedCategory in
                withAnimation(.easeInOut(duration: 0.3)) {
                    store.dispatch(.toggleAIRecommendBar(selectedCategory: selectedCategory))
                }
            }
        )
            
    }
    
    private var townSelectWithGuide: some View {
        HStack(alignment: .center, spacing: 0) {
            townSelect
            Spacer()
            guideButton
        }
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.vertical, 16.adjustedHeight)
    }
    
    private var townSelect: some View {
        Button {
            
        } label: {
            HStack(alignment: .center, spacing: 4.adjustedWidth) {
                Image(.townIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24.adjusted, height: 24.adjusted)
                
                Text("filterTitle")
                    .applySolplyFont(.body_16_m)
                    .foregroundStyle(.coreBlack)
//                    .customLoading(.JGDButtonLoading, isLoading: isLoading)
                
                Image(.arrowRightIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24.adjusted, height: 24.adjusted)
            }
        }
        .buttonStyle(.plain)
    }
    
    private var guideButton: some View {
        Button {
            
        } label: {
            HStack(alignment: .center, spacing: 2) {
                Text("작성 가이드")
                    .applySolplyFont(.button_12_m)
                    .foregroundStyle(.gray600)
                Image(.infoIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20.adjusted, height: 20.adjusted)
            }
        }
        .buttonStyle(.plain)
    }
    
    private var aiRecommendPromptField: some View {
        SolplyTextEditor(
            placeholder: "작업하기 좋은 우드톤 카페\n시간 제한 없는 조용한 디저트 카페\n혼자 생각 정리하기 좋은 산책로",
            isTextLimitEnabled: true
        )
    }
    
    private var popularRecommend: some View {
        PopularRecommend(popularPrompt: ["성수에서 작업하기 좋은 조용한 카페 추천해줘", "망원에서 혼자 오래 머물기 좋은 카페", "연남동 디저트가 맛있는 감성카페", "서촌 사색하기 좋은 책방"])
            .padding(.top, 24.adjustedHeight)
    }
    
    private var aiRecommendButton: some View {
        SolplyMainButton(title: "추천 받기", isEnabled: true)
            .padding(.horizontal, 20.adjustedWidth)
            .padding(.top, 36.adjustedHeight)
    }
}

#Preview {
    AIRecommendPromptView()
}
