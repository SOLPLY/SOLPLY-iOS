//
//  PlaceRecommendEffect.swift
//  Solply
//
//  Created by seozero on 7/17/25.
//

import Foundation

struct PlaceRecommendEffect {
    private let placeService: PlaceAPI
    private let recommendService: RecommendAPI
    private let tagsService = TagsService()
    
    init(
        placeService: PlaceAPI,
        recommendService: RecommendAPI
    ) {
        self.placeService = placeService
        self.recommendService = recommendService
    }
    
    func fetchPlaceRecommend(townId: Int) async -> PlaceRecommendAction {
        do {
            let response = try await recommendService.fetchPlaceRecommend(townId: townId)
            
            guard let data = response.data else {
                return .errorOccurred(error: .responseError)
            }
            return .placeRecommendFetched(data.placeInfos)
        } catch let error as NetworkError {
            return .errorOccurred(error: error)
        } catch {
            return .errorOccurred(error: .unknownError)
        }
    }
    
    func fetchMainTags() async -> PlaceRecommendAction {
        do {
            let response = try await tagsService.fetchMainTags()
            
            guard let data = response.data else {
                return .errorOccurred(error: .responseError)
            }
            
            return .mainTagsFetched(data.tags)
        } catch let error as NetworkError {
            return .errorOccurred(error: error)
        } catch {
            return .errorOccurred(error: .unknownError)
        }
    }
    
    func fetchSubTags(parentId: Int) async -> PlaceRecommendAction {
        do {
            let response = try await tagsService.fetchSubTags(parentId: parentId)
            
            guard let data = response.data else {
                return .errorOccurred(error: .responseError)
            }
            
            return .subTagsFetched(data.tags)
        } catch let error as NetworkError {
            return .errorOccurred(error: error)
        } catch {
            return .errorOccurred(error: .unknownError)
        }
    }
    
    func fetchPlaceList(
        townId: Int,
        isBookmarkSearch: Bool,
        mainTagId: Int?,
        subTagAIdList: [Int]?,
        subTagBIdList: [Int]?
    ) async -> PlaceRecommendAction {
        do {
            let response = try await placeService.fetchPlaceList(
                townId: townId,
                isBookmarkSearch: isBookmarkSearch,
                mainTagId: mainTagId,
                subTagAIdList: subTagAIdList,
                subTagBIdList: subTagBIdList
            )
            
            guard let data = response.data else {
                return .fetchPlaceListFailed(error: .responseError)
            }
            
            return .placeListFetched(data.places)
        } catch let error as NetworkError {
            return .fetchPlaceListFailed(error: error)
        } catch {
            return .fetchPlaceListFailed(error: .unknownError)
        }
    }
}
