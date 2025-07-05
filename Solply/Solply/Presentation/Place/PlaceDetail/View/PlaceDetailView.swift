//
//  PlaceDetailView.swift
//  Solply
//
//  Created by 김승원 on 6/29/25.
//

import SwiftUI

struct PlaceDetailView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject private var store = PlaceDetailStore()
    
    // MARK: - Body
    
    var body: some View {
        NMapView(coordinate: (126.9784147, 37.5666805))
            .detailBottomSheet {
                bottomSheetTopButtons
            } sheetContent: {
                bottomSheetContent
            }
    }
}

// MARK: - Subviews

extension PlaceDetailView {
    private var bottomSheetTopButtons: some View {
        HStack(alignment: .center, spacing: 8.adjustedWidth) {
            FindDirectionButton(isEnabled: store.state.findDirectionEnabled) {
                store.dispatch(.requestFindDirection)
            }
            
            Spacer()
            
            SolplyAddButton(isSelected: store.state.addButtonSelected) {
                store.dispatch(.toggleAddToCourse)
            }
            .animation(.easeIn(duration: 0.2), value: store.state.saveButtonSelected)
            
            SolplySaveButton(
                contentType: .place,
                isEnabled: store.state.saveButtonEnabled,
                isSelected: store.state.saveButtonSelected
            ) {
                store.dispatch(.toggleSavePlace)
            }
        }
        .padding(.horizontal, 20.adjustedWidth)
    }
    
    private var bottomSheetContent: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("아 되나?")
        }
        
    }
}

#Preview {
    PlaceDetailView()
        .environmentObject(AppCoordinator())
}
