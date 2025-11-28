//
//  RegisteredPlacesView.swift
//  Solply
//
//  Created by seozero on 11/18/25.
//

import SwiftUI

struct RegisteredPlacesView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store = RegisteredPlacesStore()
    
    private let userId: Int
    
    private let columns = [
        GridItem(.fixed(165.adjusted), spacing: 12.5.adjustedWidth),
        GridItem(.fixed(165.adjusted))
    ]
    
    // MARK: - Initializer
    
    init(userId: Int) {
        self.userId = userId
    }
    
    // MARK: - Body
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16.adjustedHeight) {
            ForEach(store.state.registeredPlaces) { place in
                PlaceCard(
                    isSaved: place.isBookmarked,
                    thumbnailUrl: place.thumbnail,
                    placeName: place.name,
                    placeCategory: place.mainTag,
                    isSelected: false
                ) {
                    appCoordinator.navigate(
                        to: .placeDetail(
                            townId: place.townId,
                            placeId: place.id,
                            fromSearch: false
                        )
                    )
                }
            }
        }
        .customNavigationBar(.registeredPlace(backAction: appCoordinator.goBack))
        .onAppear {
            store.dispatch(.fetchRegisteredPlaces(
                userId: userId,
                page: 0,
                size: 100
            ))
        }
    }
}
