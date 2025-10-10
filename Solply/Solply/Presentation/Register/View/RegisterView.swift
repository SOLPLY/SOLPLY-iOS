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
                searchBar
                
                placeType
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
    private var searchBar: some View {
        VStack(alignment: .leading, spacing: 12.adjustedHeight) {
            Text("장소 이름")
                .applySolplyFont(.body_16_m)
                .foregroundStyle(.coreBlack)
                .padding(.horizontal, 16.adjustedWidth)
            
            Group {
                switch store.state.registerStep {
                case .searchPlace:
                    VStack(alignment: .center, spacing: 28.adjustedHeight) {
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
    
    private var placeType: some View {
        VStack(alignment: .center, spacing: 12.adjustedHeight) {
            Text("장소 이름")
                .applySolplyFont(.body_16_m)
                .foregroundStyle(.coreBlack)
            
            // TODO: - 드롭다운 연결
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16.adjustedWidth)
    }
}

#Preview {
    RegisterView()
        .environmentObject(AppCoordinator())
}
