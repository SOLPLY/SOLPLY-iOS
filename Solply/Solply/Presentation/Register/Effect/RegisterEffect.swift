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
    private let fileService: FileAPI
    private let uploadPhotosService: UploadPhotosAPI
    
    init(
        tagsService: TagsAPI,
        naverPlaceSearchService: NaverPlaceSearchAPI,
        placeService: PlaceAPI,
        fileService: FileAPI,
        uploadPhotosService: UploadPhotosAPI
    ) {
        self.tagsService = tagsService
        self.naverPlaceSearchService = naverPlaceSearchService
        self.placeService = placeService
        self.fileService = fileService
        self.uploadPhotosService = uploadPhotosService
    }
}

// MARK: - TagsAPI

extension RegisterEffect {
    func fetchSubTags(parentId: Int) async -> RegisterAction {
        do {
            let response = try await tagsService.fetchSubTags(
                tagUsage: SolplyContentType.place.apiValue,
                parentId: parentId
            )
            
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

// MARK: - FileAPI

extension RegisterEffect {
    func submitPresignedUrlRequest(request: PresignedUrlRequestDTO) async -> RegisterAction {
        do {
            let response = try await fileService.submitPresignedUrlRequest(request: request)
            
            guard let data = response.data else {
                return .submitPresignedUrlRequestFailed(error: .responseError)
            }
            
            return .presignedUrlRequestSubmitted(response: data)
            
        } catch let error as NetworkError {
            return .submitPresignedUrlRequestFailed(error: error)
        } catch {
            return .submitPresignedUrlRequestFailed(error: .unknownError)
        }
    }
}

// MARK: - UploadPhotoAPI

extension RegisterEffect {
    func uploadImages(dictionary: [URL: Data]) async -> RegisterAction {
        do {
            let response = try await uploadPhotosService.uploadImages(dictionary)
            
            return .photoUploadSuccess(imageKeys: response)
        } catch let error as NetworkError {
            return .photoUploadFailed(error: error)
        } catch {
            return .photoUploadFailed(error: .unknownError)
        }
    }
}
