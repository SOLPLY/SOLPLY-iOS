//
//  AIRecommendPromptState.swift
//  Solply
//
//  Created by seozero on 3/15/26.
//

import Foundation

struct AIRecommendPromptState {
    var isLoading: Bool = false
    
    var promptContent: String = ""
    // TODO: - API 연동 필요
    var popularRecommends: [String] = [
        "성수에서 작업하기 좋은 조용한 카페 추천해줘",
        "망원에서 혼자 오래 머물기 좋은 카페",
        "연남동 디저트가 맛있는 감성카페",
        "서촌 사색하기 좋은 책방"
    ]
    
    var selectedCategory: SolplyContentType = .place
    var isWritingGuidePresented: Bool = false
    // TODO: - 활성화 상태 수정 필요
    var isRecommendButtonEnabled: Bool = false
    var isTownSelectBottomSheetPresented: Bool = false
    
    // MARK: - TownSelectBottomSheet
    
    var isTownLoading: Bool = false
    var isCompleteButtonLoading: Bool = false
    
    var initialTownId: Int = 0
    var currentSelectedSubTown: SubTown? = nil
    
    var townList: [Town] = []
    var selectedTown: Town? = nil
    var selectedSubTown: SubTown? = nil
    
    
}
