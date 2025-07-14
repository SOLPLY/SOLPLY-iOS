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
        PlaceDetailMapView(place: Place.mockData())
            .customNavigationBar(
                .placeDetail(
                    title: "이거는 받아야지",
                    backAction: {
                        appCoordinator.goBack()
                    },
                    homeAction: {
                        appCoordinator.goToRoot()
                    }
                )
            )
            .detailBottomSheet(maxState: .placeExpended) {
                bottomSheetTopButtons
            } sheetContent: {
                bottomSheetContent
            }
            .ignoresSafeArea(edges: .bottom)
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
            
            AddToCourseButton(isSelected: store.state.addButtonSelected) {
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
        ZStack {
            if store.state.addButtonSelected {
                AddPlaceToCourseView {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        store.dispatch(.toggleAddToCourse)
                    }
                }
                .transition(.move(edge: .trailing))
            } else {
                PlaceInformationView()
                    .padding(.top, 8.adjustedHeight)
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: store.state.addButtonSelected)
    }
}

#Preview {
    PlaceDetailView()
        .environmentObject(AppCoordinator())
}
