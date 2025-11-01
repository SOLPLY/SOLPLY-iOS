//
//  PlaceSearchView.swift
//  Solply
//
//  Created by LEESOOYONG on 9/15/25.
//

import SwiftUI

struct PlaceSearchView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject var store = PlaceSearchStore()
    
    private let onSubmit: ((String) -> Void)?
    
    // MARK: - Initializer
    
    init(
        onSubmit: ((String) -> Void)? = nil
        
    ) {
        self.onSubmit = onSubmit
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 28.adjustedHeight) {
            SearchBar { text in
                store.dispatch(.searchPlace(placeName: text))
            }
            
            if store.state.isSearchCompleted {
                if store.state.places.isEmpty {
                    PlaceEmptyView() {
                        appCoordinator.navigate(to: .register)
                    }
                } else {
                    PlaceDataView(places: store.state.places) { townId, placeId in
                        appCoordinator.navigate(to: .placeDetail(townId: townId, placeId: placeId, fromSearch: true))
                    } registerAction: {
                        appCoordinator.navigate(to: .register)
                    }
                }
            }
        }
        .customNavigationBar(.placeSearch(backAction: appCoordinator.goBack))
        .ignoresSafeArea(edges: .bottom)
        .background(.coreWhite)
        .onTapGesture {
            hideKeyboard()
        }
    }
}
