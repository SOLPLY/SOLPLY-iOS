//
//  PlaceSearchView.swift
//  Solply
//
//  Created by LEESOOYONG on 9/15/25.
//

import SwiftUI

struct PlaceSearchView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @EnvironmentObject private var toastManager: ToastManager
    @EnvironmentObject private var alertManager: AlertManager
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
            
            Group {
                if store.state.isSearchCompleted {
                    if store.state.searchedPlaces.isEmpty {
                        PlaceEmptyView() {
                            requireLogin {
                                appCoordinator.navigate(to: .register)
                            }
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
                            requireLogin {
                                appCoordinator.navigate(to: .register)
                            }
                        }
                    }
                }
            }
            .customLoading(.searchLoading, isLoading: store.state.isSearchLoading)
        }
        .frame(maxWidth: .infinity)
        .customNavigationBar(
            .backWithTitle(
                title: "검색하기",
                backAction: { appCoordinator.goBack() }
            )
        )
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

// MARK: - Functions

extension PlaceSearchView {
    private func requireLogin(_ action: (() -> Void)) {
        switch appState.userSession {
        case .explore:
            showLoginAlert()
        case .authenticated:
            action()
        }
    }
    
    private func showLoginAlert() {
        alertManager.showAlert(alertType: .authenticationRequired, onCancel: nil) {
            appCoordinator.changeRoot(to: .auth)
        }
    }
}
