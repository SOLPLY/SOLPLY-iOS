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
    
    @State private var text: String = ""
    private let onChange: ((String) -> Void)?
    private let onSubmit: ((String) -> Void)?
    
    // MARK: - Initializer
    
    init(
        onChange: ((String) -> Void)? = nil,
        onSubmit: ((String) -> Void)? = nil
        
    ) {
        self.onChange = onChange
        self.onSubmit = onSubmit
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 28.adjustedHeight) {
            SearchBarView(store: store, onChange: onChange, onSubmit: onSubmit)
            
            if store.state.isSearchCompleted {
                if store.state.places.isEmpty {
                    PlaceEmptyView()
                } else {
                    PlaceDataView(store: store)
                }
            }
        }
        .customNavigationBar(.placeSearch(backAction: appCoordinator.goBack))
    }
}
