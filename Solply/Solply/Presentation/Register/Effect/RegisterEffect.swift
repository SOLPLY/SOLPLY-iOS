//
//  RegisterEffect.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import Foundation

struct RegisterEffect {
    private let tagsService: TagsAPI
    private let naverPlaceSearchService: NaverPlaceSearchAPI
    
    init(tagsService: TagsAPI, naverPlaceSearchService: NaverPlaceSearchAPI) {
        self.tagsService = tagsService
        self.naverPlaceSearchService = naverPlaceSearchService
    }
}

// MARK: - TagsAPI

extension RegisterEffect {
    func fetchSubTags(parentId: Int) async -> RegisterAction {
        do {
            let response = try await tagsService.fetchSubTags(parentId: parentId)
            
            guard let data = response.data?.tags else {
                return .errorOccured(error: .responseError)
            }
            
            let subTags = data.map { subTagDTO in
                SubTag(dto: subTagDTO)
            }
            
            let selectableTags = subTags.map { dto in
                SelectableSubTag(from: dto)
            }
            
            return .subTagsFetched(selectableSubTags: selectableTags)
        } catch let error as NetworkError {
            return .errorOccured(error: error)
        } catch {
            return .errorOccured(error: .unknownError)
        }
    }
}

// MARK: - NaverPlaceSearchAPI

extension RegisterEffect {
    func fetchPlaces(for query: String) async -> RegisterAction {
        do {
            let response = try await naverPlaceSearchService.fetchSearchPlaces(for: query)
            
            let places = response.items.map { item in
                RegisterSearch(
                    placeName: item.title,
                    placeAddress: item.roadAddress
                )
            }
            return .searchPlacesFetched(places: places)
        } catch let error as NetworkError {
            return .fetchSearchPlacesFailed(error: error)
        } catch {
            return .fetchSearchPlacesFailed(error: NetworkError.unknownError)
        }
    }
}
