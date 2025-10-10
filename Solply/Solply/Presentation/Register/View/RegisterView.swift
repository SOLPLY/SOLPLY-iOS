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
            searchBar
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
                                // TODO: - 직접 등록 연결
                            }
                        )
                        .padding(.horizontal, 16.adjustedWidth)
                        
                        if !store.state.searchResult.isEmpty {
                            RegisterSearchList(searchResult: store.state.searchResult) { result in
                                
                            }
                        }
                    }
                case .selectMainTagType:
                    Text("")
                case .selectExtraFeatures:
                    Text("")
                }
            }
        }
        .padding(.top, 16.adjustedHeight)
    }
}

#Preview {
    RegisterView()
        .environmentObject(AppCoordinator())
}
