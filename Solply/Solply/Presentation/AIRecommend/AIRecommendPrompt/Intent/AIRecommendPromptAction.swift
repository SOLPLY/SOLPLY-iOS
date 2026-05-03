//
//  AIRecommendPromptAction.swift
//  Solply
//
//  Created by seozero on 3/15/26.
//

import Foundation

enum AIRecommendPromptAction {
    case onAppear(townId: Int, townName: String)
    case onNavigate
    
    case selectTab(selectedCategory: SolplyContentType)
    case toggleWritingGuide
    case updatePromptText(String)
    case aiRecommendButtonTapped
    case popularPromptTapped(prompt: String)
    
    case showTownSelectBottomSheet(isSheetPresented: Bool)
    case selectTown(Town)
    case selectSubTown(SubTown)
    case completeTownSelect(town: Town, subTown: SubTown)
    
    // api
    case submitAIPlaceRecommend(townId: Int, prompt: String)
    case submitAIPlaceRecommendSuccess(result: [AIRecommendCard])
    case submitAIPlaceRecommendFailed(error: NetworkError)
    
    case submitAICourseRecommend(townId: Int, prompt: String)
    case submitAICourseRecommendSuccess(result: [AIRecommendCard])
    case submitAICourseRecommendFailed(error: NetworkError)
    
    case fetchTowns
    case fetchTownsSuccess(townList: [Town])
    case fetchTownsFailure(error: NetworkError)
}
