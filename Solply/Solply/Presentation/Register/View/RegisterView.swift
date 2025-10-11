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
    @StateObject private var store = RegisterStore()
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 40.adjustedHeight) {
                searchPlace
                
                selectMainTagType
                
                selectExtraFeatures
            }
        }
        .customNavigationBar(
            .register(backAction: {
                appCoordinator.goBack()
            })
        )
        .ignoresSafeArea(edges: .bottom)
    }
}

// MARK: - Subviews

extension RegisterView {
    /// 장소 이름 검색
    private var searchPlace: some View {
        VStack(alignment: .leading, spacing: 12.adjustedHeight) {
            Text("장소 이름")
                .applySolplyFont(.body_16_m)
                .foregroundStyle(.coreBlack)
                .padding(.horizontal, 20.adjustedWidth)
            
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
                                // TODO: - 네이버 검색 API 연동
                                store.dispatch(.tempAction)
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
                        if !store.state.searchResult.isEmpty {
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
                        Text(store.state.placeName)
                            .applySolplyFont(.body_16_r)
                            .foregroundStyle(.coreBlack)
                            .frame(height: store.state.placeAddress == nil ? 28.adjustedHeight : 24.adjustedHeight)
                            .lineLimit(1)
                        
                        if let placeAddress = store.state.placeAddress {
                            Text(placeAddress)
                                .applySolplyFont(.caption_12_r)
                                .foregroundStyle(.gray700)
                                .lineLimit(1)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20.adjustedWidth)
                    .padding(.vertical, 12.adjustedHeight)
                    .background(.coreWhite)
                    .cornerRadius(20, corners: .allCorners)
                    .addBorder(.roundedRectangle(cornerRadius: 20), borderColor: .gray300, borderWidth: 1)
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
                    Text("장소 이름")
                        .applySolplyFont(.body_16_m)
                        .foregroundStyle(.coreBlack)
                        .padding(.horizontal, 20.adjustedWidth)
                    
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
                        selectableSubTagSection(
                            title: "장소와 어울리는 키워드를 골라주세요",
                            tags: Binding(
                                get: { store.state.selectableSubTagsA },
                                set: { store.dispatch(.selectSubTagA(selectableSubTags: $0)) }
                            )
                        )
                    }
                    
                    // SubTagTypeB 선택
                    if !store.state.selectableSubTagsB.isEmpty {
                        selectableSubTagSection(
                            title: "장소의 특징을 선택해주세요",
                            tags: Binding(
                                get: { store.state.selectableSubTagsB },
                                set: { store.dispatch(.selectSubTagB(selectableSubTags: $0)) }
                            )
                        )
                    }
                    
                    
                }
            }
        }
    }
    
    private func selectableSubTagSection(
        title: String,
        tags: Binding<[SelectableSubTag]>
    ) -> some View {
        VStack(alignment: .leading, spacing: 12.adjustedHeight) {
            Text(title)
                .applySolplyFont(.body_16_m)
                .foregroundStyle(.coreBlack)
                .lineLimit(1)
                .padding(.horizontal, 20.adjustedWidth)

            SeletableChipsFlowView(tags: tags)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    RegisterView()
        .environmentObject(AppCoordinator())
}
