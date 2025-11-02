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
    private let placeService: PlaceAPI
    
    init(
        tagsService: TagsAPI,
        naverPlaceSearchService: NaverPlaceSearchAPI,
        placeService: PlaceAPI
    ) {
        self.tagsService = tagsService
        self.naverPlaceSearchService = naverPlaceSearchService
        self.placeService = placeService
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
                    placeName: HTMLCleaner.clean(item.title),
                    placeAddress: item.roadAddress.isEmpty ? item.address : item.roadAddress
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

// MARK: - PlaceAPI

extension RegisterEffect {
    func submitRegister(request: RegisterRequestDTO) async -> RegisterAction {
        do {
            let response = try await placeService.submitRegister(request: request)
            _ = try await Task.sleep(nanoseconds: 2_000_000_000)
            
            guard let _ = response.data else { return .submitRegisterFailed(error: .responseError)}
            
            return .registerSubmitted
        } catch let error as NetworkError {
            return .submitRegisterFailed(error: error)
        } catch {
            return .submitRegisterFailed(error: .unknownError)
        }
    }
}
