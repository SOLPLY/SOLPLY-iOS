//
//  RegisteredPlacesView.swift
//  Solply
//
//  Created by seozero on 11/18/25.
//

import SwiftUI

struct RegisteredPlacesView: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store = RegisteredPlacesStore()
    
    private let columns = [
        GridItem(.fixed(165.adjustedWidth), spacing: 12.5.adjustedWidth),
        GridItem(.fixed(165.adjustedWidth))
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16.adjustedHeight) {
            ForEach(store.state.registeredPlaces, id: \.id) { place in
                PlaceCard(
                    isSaved: place.isBookmarked,
                    thumbnailUrl: place.thumbnail,
                    placeName: place.name,
                    placeCategory: place.mainTag,
                    isSelected: true
                )
            }
        }
    }
}
