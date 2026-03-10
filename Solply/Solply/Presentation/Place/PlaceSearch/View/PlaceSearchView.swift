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
                            appState.requireLoginWithAlert {
                                appCoordinator.navigate(to: .register)
                            } onExplore: {
                                AmplitudeManager.shared.track(.viewLoginRequiredAlert(entryMode: .guest, blockedAction: .requestPlaceRegister))
                                appCoordinator.changeRoot(to: .auth)
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
                            appState.requireLoginWithAlert {
                                AmplitudeManager.shared.track(.clickManualPlaceEntry(entryRoute: .notFound))
                                appCoordinator.navigate(to: .register)
                            } onExplore: {
                                AmplitudeManager.shared.track(.viewLoginRequiredAlert(entryMode: .guest, blockedAction: .requestPlaceRegister))
                                appCoordinator.changeRoot(to: .auth)
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
    }
}
