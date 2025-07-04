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
        ZStack(alignment: .bottom) {
            NMapView(coordinate: (126.9784147, 37.5666805))
                .ignoresSafeArea()
            
            bottomSheet
        }
        .ignoresSafeArea()
    }
}

// MARK: - Subviews

extension PlaceDetailView {
    private var bottomSheet: some View {
        VStack(alignment: .center, spacing: 12.adjustedHeight) {
            HStack(alignment: .center, spacing: 8.adjustedWidth) {
                FindDirectionButton(isEnabled: store.state.findDirectionEnabled) {
                    
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
            
            ZStack(alignment: .center) {
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 480.adjustedHeight)
                    .foregroundStyle(.coreWhite)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        
    }
}

#Preview {
    PlaceDetailView()
        .environmentObject(AppCoordinator())
}
