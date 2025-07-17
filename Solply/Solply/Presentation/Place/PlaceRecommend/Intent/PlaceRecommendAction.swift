//
//  PlaceRecommendAction.swift
//  Solply
//
//  Created by seozero on 7/8/25.
//

import Foundation

enum PlaceRecommendAction {
    case toggleCategoryBottomSheet
    case dismissCategoryBottomSheet
    case selectCategory(PlaceCategoryType)
    
    case toggleMoreOptionBottomSheet
    case dismissMoreOptionBottomSheet
    
    case confirmMoreOptionTags([SelectableOptionTag])
    
    // api
    case fetchPlaceRecommend(townId: Int)
    case placeRecommendFetched([PlaceInfoDTO])
    case errorOccurred(error: NetworkError)
}
