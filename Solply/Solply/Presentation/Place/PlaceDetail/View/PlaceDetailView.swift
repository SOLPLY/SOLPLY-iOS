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
        VStack(alignment: .center, spacing: 0) {
            // TODO: 뷰 스위칭
//            PlaceInformationView()
//                .padding(.top, 8.adjustedHeight)
            AddPlaceToCourseView()
        }
        
    }
}

#Preview {
    PlaceDetailView()
        .environmentObject(AppCoordinator())
}
