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
    
    private let title: String
    
    // MARK: - Initializer
    
    init(title: String) {
        self.title = title
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 28.adjustedHeight) {
                HStack(alignment: .center, spacing: 0) {
                    Text(title)
                        .applySolplyFont(.display_20_sb)
                    Spacer()
                }
                .padding(.horizontal, 20.adjustedWidth)
                
                TodayPlaceRecommendCarousel(placeRecommendItems: store.state.placeRecommendItems)
                
                FilterPlaceGrid()
                    .padding(.horizontal, 16.adjustedWidth)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 112.adjustedHeight)
        }
        .background(.gray100)
    }
}

#Preview {
    PlaceRecommendView()
        .environmentObject(AppCoordinator())
}
