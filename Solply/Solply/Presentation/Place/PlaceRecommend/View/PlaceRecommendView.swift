//
//  PlaceView.swift
//  Solply
//
//  Created by 김승원 on 6/28/25.
//

import SwiftUI

struct PlaceRecommendView: View {
    
    // MARK: - Properties
    @EnvironmentObject var appCoordinator: AppCoordinator
    @StateObject private var store = PlaceRecommendStore()
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 0) {
                TodayPlaceRecommendCarousel(placeRecommendItems: store.state.items)
            }
            .frame(height: 1000)
            .frame(maxWidth: .infinity)
        }
        .background(.gray100)
    }
}

#Preview {
    PlaceRecommendView()
        .environmentObject(AppCoordinator())
}
