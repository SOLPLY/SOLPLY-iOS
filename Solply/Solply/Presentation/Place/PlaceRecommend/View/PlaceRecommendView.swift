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
                
                if !store.state.placeRecommendItems.isEmpty {
                    TodayPlaceRecommendCarousel(store: store)
                }
                
                FilterPlaceGrid(store: store)
                    .padding(.horizontal, 16.adjustedWidth)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 112.adjustedHeight)
        }
        .background(.gray100)
        .task {
            // TODO: - townId 바인딩 필요
            store.dispatch(.fetchPlaceRecommend(townId: 2))
            
            let subTagAIdList = store.state.selectedSubTags
                .filter { $0.tagType == "OPTION1" && $0.isSelected }
                .map { $0.id }
            
            let subTagBIdList = store.state.selectedSubTags
                .filter { $0.tagType == "OPTION2" && $0.isSelected }
                .map { $0.id }
            
            // TODO: - townId 바인딩 필요
            store.dispatch(.fetchPlaceList(
                townId: 2,
                isBookmarkSearch: false,
                mainTagId: store.state.selectedMainTag.parentId == 0 ? nil : store.state.selectedMainTag.parentId,
                subTagAIdList: subTagAIdList,
                subTagBIdList: subTagBIdList
            ))
        }
    }
}

#Preview {
    PlaceRecommendView()
        .environmentObject(AppCoordinator())
}
