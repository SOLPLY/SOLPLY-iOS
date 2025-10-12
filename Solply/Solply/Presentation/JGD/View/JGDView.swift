//
//  JGDView.swift
//  Solply
//
//  Created by seozero on 9/11/25.
//

import SwiftUI

struct JGDView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject var store = JGDStore()
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .center, spacing: 0) {
                Rectangle()
                    .frame(height: 1.adjustedHeight)
                    .foregroundStyle(.gray300)
                
                HStack(alignment: .top, spacing: 0) {
                    topTownListView
                    Divider()
                    subTownListView
                }
            }
            .customNavigationBar(
            .frequentTown(backAction: appCoordinator.goBack)
            )
            .ignoresSafeArea(edges: .bottom)
            
            CTAMainButton(
                title: "완료",
                isEnabled: store.state.selectedSubTown != nil
            ) {
                if let top = store.state.selectedTopTown,
                   let sub = store.state.selectedSubTown {
                    store.dispatch(.saveSelection(selectedTopTown: top, selectedSubTown: sub))
                }
                appCoordinator.goBack()
            }
            .padding(.horizontal, 20.adjustedWidth)
            .padding(.bottom, 16.adjustedHeight)
        }
        .onAppear {
            store.dispatch(.fetchTopTowns)
        }
    }
}

// MARK: - Subviews

private extension JGDView {
    var topTownListView: some View {
        VStack(alignment: .center, spacing: 0) {
            VStack(alignment: .center, spacing: 0) {
                ForEach(store.state.topTownList, id: \.id) { topTown in
                    JGDTopTownRow(
                        title: topTown.name,
                        isSelected: store.state.selectedTopTown?.id == topTown.id
                    ) {
                        store.dispatch(.selectTopTown(topTown))
                    }
                }
            }
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .background(.gray100)
    }

    var subTownListView: some View {
        let subTowns = store.state.selectedTopTown?.subTowns ?? []
        return VStack(alignment: .center, spacing: 0) {
            ForEach(subTowns, id: \.id) { town in
                JGDSubTownRow(
                    title: town.name,
                    isSelected: store.state.selectedSubTown?.id == town.id,
                    onTap: {
                        store.dispatch(.selectSubTown(town))
                        print("🏡 town → id:\(town.id), name:\(town.name)")
                    }
                )
            }
            Spacer(minLength: 0)
        }
        .frame(width: 247.adjustedWidth)
    }
}
