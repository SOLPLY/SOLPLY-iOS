//
//  PlaceRecommendAction.swift
//  Solply
//
//  Created by seozero on 7/8/25.
//

import Foundation

enum PlaceRecommendAction {
    case onAppear(townId: Int)
    case resetTags
    
    case toggleMainTagBottomSheet
    case dismissMainTagBottomSheet
    case selectMainTag(MainTagType)
    
    case toggleSubTagBottomSheet
    case dismissSubTagBottomSheet
        
    case updateMainTag
    case resetSubTags
    case updateSubTags([SelectableSubTag])
    
    // api
    case fetchPlaceRecommend(townId: Int)
    case placeRecommendFetched([PlaceInfoDTO])
    case fetchPlaceRecommendFailed(error: NetworkError)
    
    case fetchMainTags
    case mainTagsFetched([MainTagDTO])
    
    case fetchSubTags(parentId: Int)
    case subTagsFetched([SubTagDTO])
    
    case fetchPlaceList(
        townId: Int,
        isBookmarkSearch: Bool,
        mainTagId: Int?,
        subTagAIdList: [Int]?,
        subTagBIdList: [Int]?
    )
    case placeListFetched([PlaceDTO])
    case fetchPlaceListFailed(error: NetworkError)
    
    case errorOccurred(error: NetworkError)
}
