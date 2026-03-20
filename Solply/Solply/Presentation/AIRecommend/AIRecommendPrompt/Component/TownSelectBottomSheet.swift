//
//  TownSelectBottomSheet.swift
//  Solply
//
//  Created by seozero on 3/19/26.
//

import SwiftUI

struct TownSelectBottomSheet: View {
    
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var store = AIRecommendPromptStore()
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            header
            
            divider
            
            ZStack(alignment: .bottom) {
                VStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .top, spacing: 0) {
                        townListView
                        
                        Divider()
                        
                        subTownListView
                    }
                }
                
                SolplyMainButton(
                    title: "완료",
                    isEnabled: true
                ) {
                    
                }
                .padding(.horizontal, 20.adjustedWidth)
                .padding(.bottom, 38.adjustedHeight)
            }
        }
        .onAppear {
            store.dispatch(.fetchTowns)
        }
    }
}

// MARK: - Subviews

extension TownSelectBottomSheet {
    private var header: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("동네")
                .applySolplyFont(.title_18_sb)
                .foregroundStyle(.coreBlack)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Image(.xIconSm)
                    .resizable()
                    .frame(width: 24.adjusted, height: 24.adjusted)
                    .foregroundStyle(.gray800)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16.adjustedWidth)
        .padding(.top, 24.adjustedHeight)
        .padding(.bottom, 20.adjustedHeight)
    }
    
    private var divider: some View {
        Rectangle()
            .frame(height: 1.adjustedHeight)
            .foregroundStyle(.gray300)
    }
    
    private var townListView: some View {
        VStack(spacing: 0) {
            ForEach(store.state.townList, id: \.self) { town in
                JGDTopTownRow(
                    title: town.townName,
                    isSelected: store.state.selectedTown?.id == town.id
                ) {
                    store.dispatch(.selectTown(town))
                }
            }
            
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .background(.gray100)
    }
    
    private var subTownListView: some View {
        let subTowns = store.state.selectedTown?.subTowns ?? []
        
        return VStack(spacing: 0) {
            ForEach(subTowns, id: \.self) { subTown in
                JGDSubTownRow(
                    title: subTown.townName,
                    isSelected: store.state.selectedSubTown?.id == subTown.id
                ) {
                    store.dispatch(.selectSubTown(subTown))
                }
            }
            
            Spacer()
        }
        .frame(width: 247.adjustedWidth)
    }
}
