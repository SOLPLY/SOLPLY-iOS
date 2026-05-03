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
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .center, spacing: 0) {
                    townSelectWithGuide
                    
                    aiRecommendPromptField
                    
                    popularRecommend
                }
            }
        }
        .overlay(alignment: .bottom) {
            aiRecommendButton
                .padding(.bottom, 40.adjustedHeight)
        }
        .customNavigationBar(.backWithTitle(title: "AI 추천") {
            appCoordinator.goBack()
        })
        .ignoresSafeArea(edges: .bottom)
        .customModal()
        .onTapGesture {
            hideKeyboard()
        }
        .sheet(
            isPresented: Binding(
                get: { store.state.isTownSelectBottomSheetPresented },
                set: { store.dispatch(.showTownSelectBottomSheet(isSheetPresented: $0)) }
            )
        ) {
            TownSelectBottomSheet(
                isTownLoading: store.state.isTownLoading,
                townList: store.state.townList,
                initialTown: store.state.selectedTown,
                initialSubTown: store.state.selectedSubTown,
                onAppear: { store.dispatch(.fetchTowns) },
                onComplete: { town, subTown in
                    guard let town, let subTown else { return }
                    
                    store.dispatch(.completeTownSelect(town: town, subTown: subTown))
                }
            )
            .presentationDetents([.height(654.adjustedHeight)])
            .presentationCornerRadius(20)
        }
        .onAppear {
            store.dispatch(.onAppear(townId: appState.townId, townName: appState.townName))
        }
        .onChange(of: store.state.shouldNavigate) { _, shouldNavigate in
            if shouldNavigate {
                appCoordinator.navigate(to: .aiRecommendResult(
                    prompt: store.state.promptContent,
                    cards: store.state.aiRecommendResult)
                )
                store.dispatch(.onNavigate)
            }
        }
    }
}

// MARK: - Subviews

extension AIRecommendPromptView {
    private var aiRecommendBar: some View {
        AIRecommendBar(
            selectedCategory: store.state.selectedCategory,
            action: { selectedCategory in
                withAnimation(.easeInOut(duration: 0.3)) {
                    store.dispatch(.selectTab(selectedCategory: selectedCategory))
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
            store.dispatch(.showTownSelectBottomSheet(isSheetPresented: true))
        } label: {
            HStack(alignment: .center, spacing: 4.adjustedWidth) {
                Image(.townIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24.adjusted, height: 24.adjusted)
                
                Text(store.state.selectTownHeader)
                    .applySolplyFont(.body_16_m)
                    .foregroundStyle(.coreBlack)
                
                Image(.arrowRightIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24.adjusted, height: 24.adjusted)
            }
        }
        .buttonStyle(.plain)
        .disabled(store.state.isAIRecommendLoading)
    }
    
    private var guideButton: some View {
        Button {
            showModal()
        } label: {
            HStack(alignment: .center, spacing: 2.adjustedWidth) {
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
            backgroundColor: .gray100
        ) { newText in
            store.dispatch(.updatePromptText(newText))
        }
    }
    
    private var popularRecommend: some View {
        PopularRecommend(
            popularPrompt: store.state.popularRecommends,
            isLoading: store.state.isAIRecommendLoading
        ) { text in
            store.dispatch(.popularPromptTapped(prompt: text))
        }
        .padding(.top, 24.adjustedHeight)
    }
    
    private var aiRecommendButton: some View {
        SolplyMainButton(
            title: "추천 받기",
            isEnabled: store.state.isRecommendButtonEnabled,
            isLoading: store.state.isAIRecommendLoading
        ) {
            store.dispatch(.aiRecommendButtonTapped)
        }
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.top, 36.adjustedHeight)
    }
}

// MARK: - Functions

extension AIRecommendPromptView {
    private func showModal() {
        ModalManager.shared.showModal(
            modalType: store.state.selectedCategory.modalType
        )
    }
}
