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
    
    @State private var selectedTown: Town?
    @State private var selectedSubTown: SubTown?
    
    private let isTownLoading: Bool
    private let townList: [Town]
    
    private let initialTown: Town?
    private let initialSubTown: SubTown?
    
    private let onAppear: (() -> Void)?
    private let onComplete: ((Town?, SubTown?) -> Void)?
    
    init(
        isTownLoading: Bool,
        townList: [Town],
        initialTown: Town? = nil,
        initialSubTown: SubTown? = nil,
        onAppear: (() -> Void)? = nil,
        onComplete: ((Town?, SubTown?) -> Void)? = nil
    ) {
        self.isTownLoading = isTownLoading
        self.townList = townList
        self.initialTown = initialTown
        self.initialSubTown = initialSubTown
        self.onAppear = onAppear
        self.onComplete = onComplete
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .center, spacing: 0) {
                header
                
                if !isTownLoading {
                    divider
                }
                
                HStack(alignment: .top, spacing: 0) {
                    townListView
                    
                    Divider()
                    
                    subTownListView
                }
                .customLoading(.JGDLoading, isLoading: isTownLoading)
            }
            .ignoresSafeArea(edges: .bottom)
            
            SolplyMainButton(
                title: "완료",
                isEnabled: true
            ) {
                onComplete?(selectedTown, selectedSubTown)
            }
            .padding(.horizontal, 20.adjustedWidth)
            .padding(.bottom, 38.adjustedHeight)
        }
        .onAppear {
            onAppear?()
        }
        .onChange(of: townList) {
            if selectedTown == nil {
                selectedTown = initialTown
                selectedSubTown = initialSubTown
            }
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
                    .aspectRatio(contentMode: .fit)
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
            .frame(height: 1)
            .foregroundStyle(.gray300)
    }
    
    private var townListView: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(townList, id: \.self) { town in
                JGDTopTownRow(
                    title: town.townName,
                    isSelected: selectedTown?.id == town.id
                ) {
                    selectedTown = town
                    selectedSubTown = nil
                }
            }
            
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .background(.gray100)
    }
    
    private var subTownListView: some View {
        let subTowns = selectedTown?.subTowns ?? []
        
        return VStack(alignment: .center, spacing: 0) {
            ForEach(subTowns, id: \.self) { subTown in
                JGDSubTownRow(
                    title: subTown.townName,
                    isSelected: selectedSubTown?.id == subTown.id
                ) {
                    selectedSubTown = subTown
                }
            }
            
            Spacer()
        }
        .frame(width: 247.adjustedWidth)
    }
}
