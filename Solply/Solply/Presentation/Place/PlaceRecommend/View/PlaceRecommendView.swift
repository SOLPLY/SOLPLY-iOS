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
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 28.adjustedHeight) {
                HStack(alignment: .center, spacing: 0) {
                    Text("차분함을 좋아하는\n숭이숭이숭이숭이님을 위한 오늘의 추천")
                        .applySolplyFont(.display_20_sb)
                    Spacer()
                }
                .padding(.horizontal, 20.adjustedWidth)
                
                if !store.state.placeRecommendItems.isEmpty {
                    TodayPlaceRecommendCarousel(store: store)
                }
                
                FilterPlaceGrid()
                    .padding(.horizontal, 16.adjustedWidth)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 112.adjustedHeight)
        }
        .background(.gray100)
        .task {
            // TODO: - townId 바인딩 필요
            store.dispatch(.fetchPlaceRecommend(townId: 2))
        }
    }
}

#Preview {
    PlaceRecommendView()
        .environmentObject(AppCoordinator())
}
