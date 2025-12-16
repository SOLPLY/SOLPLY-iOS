//
//  RegisterView.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import SwiftUI

struct RegisterView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @FocusState private var isFocused: Bool
    @StateObject private var store = RegisterStore()
    
    private let textEditorId: String = "textEditor"
    
    // MARK: - Body
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical) {
                VStack(alignment: .center, spacing: 40.adjustedHeight) {
                    searchPlace
                    
                    selectMainTagType
                    
                    selectExtraFeatures
                        .focused($isFocused)
                    
                    Rectangle()
                        .frame(height: 156.adjustedHeight)
                        .foregroundStyle(.clear)
                        .id(textEditorId)
                }
            }
            .scrollDisabled(store.state.registerStep != .selectExtraFeatures)
            .scrollDismissesKeyboard(.interactively)
            .onChange(of: isFocused) { _, isFocused in
                if isFocused {
                    withAnimation(.easeOut(duration: 0.3)) {
                        proxy.scrollTo(textEditorId, anchor: .bottom)
                    }
                }
            }
        }
        .overlay(alignment: .bottom) {
            if store.state.isCompleteButtonEnabled {
                completeButton
            }
        }
        .customNavigationBar(
            .register(backAction: {
                appCoordinator.goBack()
            })
        )
        .ignoresSafeArea(edges: .bottom)
        .background(.coreWhite)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

// MARK: - Subviews

extension RegisterView {
    /// 장소 이름 검색
    private var searchPlace: some View {
        VStack(alignment: .leading, spacing: 12.adjustedHeight) {
            sectionTitle("장소 이름")
            
            Group {
                switch store.state.registerStep {
                case .searchPlace:
                    VStack(alignment: .center, spacing: 28.adjustedHeight) {
                        
                        // 장소 검색바
                        RegisterSearchBar(
                            onChange: { text in
                                store.dispatch(.updateSearchBarText(text: text))
                            },
                            onSubmit: { text in
                                store.dispatch(.fetchSearchPlaces)
                            },
                            registerAction: {
                                store.dispatch(
                                    .selectPlaceToRegister(
                                        placeName: store.state.placeName,
                                        placeAddress: nil
                                    )
                                )
                            }
                        )
                        .padding(.horizontal, 16.adjustedWidth)
                        
                        // 검색 결과 List
                        if store.state.hasSearched {
                            RegisterSearchList(searchResult: store.state.searchResult) { result in
                                store.dispatch(
                                    .selectPlaceToRegister(
                                        placeName: result.placeName,
                                        placeAddress: result.placeAddress
                                    )
                                )
                            }
                        }
                    }
                    
                case .selectMainTagType, .selectExtraFeatures:
                    // 장소 이름 & 주소 컨테이너 (검색 후)
                    VStack(alignment: .leading, spacing: 4.adjustedHeight) {
                        sectionTitle(store.state.placeName)
                            .frame(height: store.state.placeAddress == nil ? 28.adjustedHeight : 24.adjustedHeight)
                        
                        if let placeAddress = store.state.placeAddress {
                            Text(placeAddress)
                                .applySolplyFont(.caption_12_r)
                                .foregroundStyle(.gray700)
                                .lineLimit(1)
                                .padding(.horizontal, 20.adjustedWidth)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 12.adjustedHeight)
                    .background(.coreWhite)
                    .cornerRadius(20, corners: .allCorners)
                    .addBorder(
                        .roundedRectangle(cornerRadius: 20),
                        borderColor: .gray300,
                        borderWidth: 1
                    )
                    .padding(.horizontal, 16.adjustedWidth)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 16.adjustedHeight)
    }
    
    /// MainTagType 선택
    private var selectMainTagType: some View {
        Group {
            switch store.state.registerStep {
            case .searchPlace:
                EmptyView()
            case .selectMainTagType, .selectExtraFeatures:
                VStack(alignment: .leading, spacing: 12.adjustedHeight) {
                    sectionTitle("장소 유형")
                    
                    SolplyDropDown(
                        title: "장소 유형을 선택해주세요",
                        tagOptions: Array(MainTagType.allCases.dropFirst()),
                        selected: store.state.selectedMainTag
                    ) { mainTag in
                        store.dispatch(.selectMainTag(mainTag: mainTag))
                        store.dispatch(.fetchSubTags(parentId: mainTag.parentId))
                    }
                    .padding(.horizontal, 16.adjustedWidth)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    /// SubTagType 선택 & 추천 이유 작성 & 사진 첨부
    private var selectExtraFeatures: some View {
        Group {
            switch store.state.registerStep {
            case .searchPlace, .selectMainTagType:
                EmptyView()
            case .selectExtraFeatures:
                VStack(alignment: .leading, spacing: 40.adjustedHeight) {
                    // SubTagTypeA 선택
                    if !store.state.selectableSubTagsA.isEmpty {
                        VStack(alignment: .leading, spacing: 12.adjustedHeight) {
                            sectionTitle("장소와 어울리는 키워드를 골라주세요")
                            
                            SeletableChipsFlowView(
                                tags: Binding(
                                    get: { store.state.selectableSubTagsA },
                                    set: { store.dispatch(.selectSubTagA(selectableSubTags: $0)) }
                                )
                            )
                            .padding(.horizontal, 16.adjustedWidth)
                        }
                    }
                    
                    // SubTagTypeB 선택
                    if !store.state.selectableSubTagsB.isEmpty {
                        VStack(alignment: .leading, spacing: 12.adjustedHeight) {
                            sectionTitle("장소의 특징을 선택해주세요")
                            
                            SeletableChipsFlowView(
                                tags: Binding(
                                    get: { store.state.selectableSubTagsB },
                                    set: { store.dispatch(.selectSubTagB(selectableSubTags: $0)) }
                                )
                            )
                            .padding(.horizontal, 16.adjustedWidth)
                        }
                    }
                    
                    // 장소 추천 이유
                    VStack(alignment: .leading, spacing: 12.adjustedHeight) {
                        sectionTitle("장소를 추천하는 이유를 작성해주세요", showsSelectionHint: true)
                        
                        SolplyTextEditor() { registerContent in
                            store.dispatch(.editReigsterContent(registerContent: registerContent))
                        }
                        .padding(.horizontal, 20.adjustedWidth)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // 사진 선택
                    VStack(alignment: .leading, spacing: 12.adjustedHeight) {
                        sectionTitle("장소의 사진이 있다면 추가해주세요", showsSelectionHint: true)
                        
                        SolplyPhotosPicker { imageData in
                            store.dispatch(.attachRegisterPhoto(imageData: imageData))
                        }
                        .padding(.horizontal, 20.adjustedWidth)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
    
    private var completeButton: some View {
        SolplyMainButton(title: "완료") {
            store.dispatch(.startRegister)
            appCoordinator.navigate(to: .registerComplete)
        }
        .padding(.horizontal, 20.adjustedWidth)
        .padding(.vertical, 40.adjustedHeight)
    }
    
    private func sectionTitle(_ title: String, showsSelectionHint: Bool = false) -> some View {
        HStack(alignment: .center, spacing: 4.adjustedWidth) {
            Text(title)
                .applySolplyFont(.body_16_m)
                .foregroundStyle(.coreBlack)
                .lineLimit(1)
            
            if showsSelectionHint {
                Text("(선택)")
                    .applySolplyFont(.body_16_m)
                    .foregroundStyle(.gray500)
            }
        }
        .padding(.horizontal, 20.adjustedWidth)
    }
}

//#Preview {
//    RegisterView()
//        .environmentObject(AppCoordinator())
//}
