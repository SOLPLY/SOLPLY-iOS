//
//  PlaceRecommendAction.swift
//  Solply
//
//  Created by seozero on 7/8/25.
//

import Foundation

enum PlaceRecommendAction {
    case toggleMainTagBottomSheet
    case dismissMainTagBottomSheet
    case selectMainTag(MainTagType)
    
    case toggleSubTagBottomSheet
    case dismissSubTagBottomSheet
    
    case confirmSubTags([SelectableSubTag])
    
    // api
    case fetchPlaceRecommend(townId: Int)
    case placeRecommendFetched([PlaceInfoDTO])
    
    case fetchMainTags
    case mainTagsFetched([MainTagDTO])
    
    case fetchSubTags(parentId: Int)
    case subTagsFetched([SubTagDTO])
    
    case errorOccurred(error: NetworkError)
}
