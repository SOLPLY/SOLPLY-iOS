//
//  PlaceSearchView.swift
//  Solply
//
//  Created by LEESOOYONG on 9/15/25.
//

import SwiftUI

struct PlaceSearchView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @EnvironmentObject private var toastManager: ToastManager
    @StateObject private var store = PlaceSearchStore()
    
    private let onSubmit: ((String) -> Void)?
    
    // MARK: - Initializer
    
    init(onSubmit: ((String) -> Void)? = nil) {
        self.onSubmit = onSubmit
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 28.adjustedHeight) {
            SearchBar { text in
                store.dispatch(.searchPlace(placeName: text))
                hideKeyboard()
            }
            
            if store.state.isSearchCompleted {
                if store.state.searchedPlaces.isEmpty {
                    PlaceEmptyView() {
                        appCoordinator.navigate(to: .register)
                    }
                } else {
                    PlaceDataView(places: store.state.searchedPlaces) { townId, placeId in
                        appCoordinator.navigate(
                            to: .placeDetail(
                                townId: townId,
                                placeId: placeId,
                                fromSearch: true
                            )
                        )
                        
                        hideKeyboard()
                    } registerAction: {
                        appCoordinator.navigate(to: .register)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .customNavigationBar(.placeSearch(backAction: appCoordinator.goBack))
        .background(.coreWhite)
        .onTapGesture {
            hideKeyboard()
        }
        .onChange(of: store.state.toastContent) { _, newValue in
            guard let toastContent = newValue else { return }
            
            toastManager.showToast(content: toastContent)
        }
    }
}
