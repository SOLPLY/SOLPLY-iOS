//
//  AIRecommendPromptView.swift
//  Solply
//
//  Created by seozero on 3/14/26.
//

import SwiftUI

struct AIRecommendPromptView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @EnvironmentObject private var appState: AppState
    @StateObject private var store = AIRecommendPromptStore()
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            aiRecommendBar
            
            townSelectWithGuide
            
            aiRecommendPromptField
            
            popularRecommend
            
            aiRecommendButton
        }
        .customNavigationBar(.backWithTitle(title: "AI 추천") {
            appCoordinator.goBack()
        })
        .overlay {
            if store.state.isWritingGuidePresented {
                ZStack(alignment: .center) {
                    Color.coreBlackO40
                        .ignoresSafeArea()
                        .onTapGesture {
                            store.dispatch(.toggleWritingGuide)
                        }
                    
                    WritingGuideModal(store.state.selectedCategory)
                }
            }
        }
        .animation(.easeInOut(duration: 0.2), value: store.state.isWritingGuidePresented)
    }
}

// MARK: - Subviews

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
                
                // TODO: - 자가동 바텀시트 연결 후 수정 필요
                Text(appState.townName)
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
            store.dispatch(.toggleWritingGuide)
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
            placeholder: store.state.selectedCategory.aiRecommendPromptPlaceholder,
            isTextLimitEnabled: true) { newText in
                store.dispatch(.updatePromptText(newText))
            }
    }
    
    private var popularRecommend: some View {
        PopularRecommend(popularPrompt: ["성수에서 작업하기 좋은 조용한 카페 추천해줘", "망원에서 혼자 오래 머물기 좋은 카페", "연남동 디저트가 맛있는 감성카페", "서촌 사색하기 좋은 책방"])
            .padding(.top, 24.adjustedHeight)
    }
    
    private var aiRecommendButton: some View {
        SolplyMainButton(
            title: "추천 받기",
            isEnabled: store.state.isRecommendButtonEnabled
        )
            .padding(.horizontal, 20.adjustedWidth)
            .padding(.top, 36.adjustedHeight)
    }
}
