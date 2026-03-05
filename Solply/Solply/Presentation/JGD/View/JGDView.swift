//
//  JGDView.swift
//  Solply
//
//  Created by seozero on 9/11/25.
//

import SwiftUI

struct JGDView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store = JGDStore()
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .center, spacing: 0) {
                Rectangle()
                    .frame(height: 1.adjustedHeight)
                    .foregroundStyle(.gray300)
                
                HStack(alignment: .top, spacing: 0) {
                    townListView
                    Divider()
                    subTownListView
                }
            }
            .customNavigationBar(
            .frequentTown(backAction: appCoordinator.goBack)
            )
            .ignoresSafeArea(edges: .bottom)
            
            SolplyMainButton(
                title: "완료",
                isEnabled: store.state.selectedSubTown != nil,
                isLoading: store.state.isCompleteButtonLoading
            ) {
                switch appState.userSession {
                case .explore:
                    appState.townId = store.state.currentSelectedSubTown?.id ?? 2
                    appState.townName = store.state.currentSelectedSubTown?.townName ?? "망원"
                    appCoordinator.goBack()
                case .authenticated:
                    store.dispatch(.saveSelection)
                }
            }
            .padding(.horizontal, 20.adjustedWidth)
            .padding(.bottom, 16.adjustedHeight)
        }
        .onAppear {
            store.dispatch(.fetchTowns)
            store.dispatch(.setInitialTownId(townId: appState.townId))
        }
        .onChange(of: store.state.shouldGoBack) { _, shouldGoBack in
            if shouldGoBack {
                appCoordinator.goBack()
            }
        }
    }
}

// MARK: - Subviews

private extension JGDView {
    var townListView: some View {
        VStack(alignment: .center, spacing: 0) {
            VStack(alignment: .center, spacing: 0) {
                ForEach(store.state.townList, id: \.id) { town in
                    JGDTopTownRow(
                        title: town.townName,
                        isSelected: store.state.selectedTown?.id == town.id
                    ) {
                        store.dispatch(.selectTown(town))
                        
                        AmplitudeManager.shared.track(
                            .selectTown(
                                townId: town.id,
                                townName: town.townName,
                                prevTownId: appState.townId
                            )
                        )
                    }
                }
            }
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .background(.gray100)
    }

    var subTownListView: some View {
        let subTowns = store.state.selectedTown?.subTowns ?? []
        return VStack(alignment: .center, spacing: 0) {
            ForEach(subTowns, id: \.id) { subTown in
                JGDSubTownRow(
                    title: subTown.townName,
                    isSelected: store.state.selectedSubTown?.id == subTown.id,
                    onTap: {
                        store.dispatch(.selectSubTown(subTown))
                        print("🏡 subTown → id:\(subTown.id), name:\(subTown.townName)")
                        
                        AmplitudeManager.shared.track(
                            .selectTown(
                                townId: subTown.id,
                                townName: subTown.townName,
                                prevTownId: appState.townId
                            )
                        )
                    }
                )
            }
            Spacer(minLength: 0)
        }
        .frame(width: 247.adjustedWidth)
    }
}
