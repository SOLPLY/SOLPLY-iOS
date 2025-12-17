//
//  JGDBottomSheet.swift
//  Solply
//
//  Created by sun on 10/6/25.
//

import SwiftUI

struct JGDBottomSheet: View {
    
    private let onDone: (_ town: Town?, _ subTown: SubTown?) -> Void
    private let onClose: (() -> Void)?
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var store = JGDStore()
    
    // MARK: - Initializer
    
    init(
        onDone: @escaping (_ town: Town?, _ subTown: SubTown?) -> Void,
        onClose: (() -> Void)? = nil
    ) {
        self.onDone = onDone
        self.onClose = onClose
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            header
            
            Rectangle()
                .frame(height: 1.adjustedHeight)
                .foregroundStyle(.gray300)
            
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    HStack(alignment: .top, spacing: 0) {
                        townListView
                        Divider()
                        subTownListView
                    }
                }
                
                SolplyMainButton(title: "완료", isEnabled: store.state.selectedSubTown != nil) {
                    onDone(store.state.selectedTown, store.state.selectedSubTown)
                    if onClose == nil { dismiss() } else { onClose?() }
                }
                .padding(.horizontal, 20.adjustedWidth)
                .padding(.bottom, 16.adjustedHeight)
            }
            .cornerRadius(20)
        }
        .onAppear {
            store.dispatch(.fetchTowns)
        }
    }
}

// MARK: - Header

private extension JGDBottomSheet {
    var header: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("동네 설정")
                .applySolplyFont(.title_18_sb)
                .foregroundStyle(.coreBlack)
            
            Spacer()
            
            Button {
                if let onClose { onClose() } else { dismiss() }
            } label: {
                Image(.xIconSm)
                    .resizable()
                    .frame(width: 24.adjustedWidth, height: 24.adjustedWidth)
                    .foregroundStyle(.gray800)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 24.adjustedWidth)
        .padding(.top, 24.adjustedHeight)
        .padding(.bottom, 20.adjustedHeight)
    }
}

// MARK: - Subviews

private extension JGDBottomSheet {
    var townListView: some View {
        VStack(alignment: .center, spacing: 0) {
            ForEach(store.state.townList, id: \.id) { town in
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

    var subTownListView: some View {
        let subTowns = store.state.selectedTown?.subTowns ?? []

        return VStack(spacing: 0) {
            ForEach(subTowns, id: \.id) { subTown in
                JGDSubTownRow(
                    title: subTown.townName,
                    isSelected: store.state.selectedSubTown?.id == subTown.id,
                    onTap: {
                        store.dispatch(.selectSubTown(subTown))
                        print("🏡 SubTown → id: \(subTown.id), name: \(subTown.townName)")
                    }
                )
            }
            Spacer()
        }
        .frame(width: 247.adjustedWidth)
    }
}

