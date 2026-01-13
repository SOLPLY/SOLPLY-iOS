//
//  PlaceDetailEffect.swift
//  Solply
//
//  Created by 김승원 on 7/16/25.
//

import Foundation

struct PlaceDetailEffect {
    private let courseService: CourseAPI
    private let placeService: PlaceAPI
    private let userService: UserAPI
    
    init(courseService: CourseAPI, placeService: PlaceAPI, userService: UserAPI) {
        self.courseService = courseService
        self.placeService = placeService
        self.userService = userService
    }
}

// MARK: - Functions

extension PlaceDetailEffect {
    func findDirection(
        with mapRouteType: MapRouteType,
        startLatitude: Double,
        startLongitude: Double,
        destinationLatitude: Double,
        destinationLongitude: Double,
        destinationName: String?
    ) {
        MapRouteHelper.findDirection(
            with: mapRouteType,
            startLatitude: startLatitude,
            startLongitude: startLongitude,
            destinationLatitude: destinationLatitude,
            destinationLongitude: destinationLongitude,
            destinationName: destinationName
        )
    }
}

// MARK: - CourseAPI

extension PlaceDetailEffect {
    func fetchCourseArchive(placeId: Int?) async -> PlaceDetailAction {
        do {
            let response = try await courseService.fetchCourseArchive(townId: nil, placeId: placeId)
            
            guard let courses = response.data?.courses else {
                return .fetchCourseArchiveFailed(error: .responseError)
            }
            
            return .courseArchiveFetched(courses)
        } catch let error as NetworkError {
            return .fetchCourseArchiveFailed(error: error)
            
        } catch {
            return .fetchCourseArchiveFailed(error: .unknownError)
        }
    }
    
    func submitAddPlace(courseId: Int, placeId: Int) async -> PlaceDetailAction {
        do {
            let response = try await courseService.submitAddPlace(courseId: courseId, placeId: placeId)
            
            guard let data = response.data else {
                return .submitAddPlaceFailed(error: .responseError)
            }
            
            return .addPlaceSubmitted(addPlaceCourseInformation: AddPlaceCourseInformation(dto: data))
            
        } catch let error as NetworkError {
            return .submitAddPlaceFailed(error: error)
        } catch {
            return .submitAddPlaceFailed(error: .unknownError)
        }
    }
}

// MARK: - PlaceAPI

extension PlaceDetailEffect {
    func fetchPlaceDetail(placeId: Int) async -> PlaceDetailAction {
        do {
            let response = try await placeService.fetchPlaceDetail(placeId: placeId)
            
            guard let data = response.data else {
                return .fetchPlaceDetailFailed(error: .responseError)
            }
            
            let placeDetailInformation = PlaceDetailInformation(
                isBookmarked: data.isBookmarked,
                primaryTag: data.mainTag,
                placeName: data.placeName,
                introduction: data.introduction,
                imageUrls: data.imageInfos.map { $0.url },
                address: data.address,
                contactNumber: data.contactNumber ?? "",
                openingHours: data.openingHours.replacingOccurrences(of: "\\n", with: "\n"),
                snsLink: data.snsLinks.map { PlaceDetailSnsLink(snsPlatform: $0.snsPlatform, url: $0.url) },
                latitude: Double(data.latitude) ?? 0.0,
                longitude: Double(data.longitude) ?? 0.0,
                placeDefaultId: data.placeDefaultId,
                placeType: data.placeType,
                townId: data.townId,
                townName: data.townName
            )
            
            return .placeDetailFetched(placeDetailInformation: placeDetailInformation)
        } catch let error as NetworkError {
            return .fetchPlaceDetailFailed(error: error)
        } catch {
            return .fetchPlaceDetailFailed(error: .unknownError)
        }
    }
    
    func submitPlaceBookmark(placeId: Int) async -> PlaceDetailAction {
        do {
            let _ = try await placeService.submitPlaceBookmark(placeId: placeId)
            
            return .placeBookmarkSubmitted
            
        } catch let error as NetworkError {
            return .submitPlaceBookmarkFailed(error: error)
        } catch {
            return .submitPlaceBookmarkFailed(error: .unknownError)
        }
    }
    
    func removePlaceBookmark(placeId: Int) async -> PlaceDetailAction {
        do {
            let _ = try await placeService.removePlaceBookmark(placeId: placeId)
            
            return . placeBookmarkRemoved
            
        } catch let error as NetworkError {
            return .removePlaceBookmarkFailed(error: error)
        } catch {
            return .removePlaceBookmarkFailed(error: .unknownError)
        }
    }
}

// MARK: - UserAPI

extension PlaceDetailEffect {
    func updateUserTowns(selectedTownId: Int) async -> PlaceDetailAction {
        do {
            
            let request = UserTownsUpdateRequestDTO(
                selectedTownId: selectedTownId
            )
            
            let response = try await userService.updateUserTowns(request)
            
            guard let data = response.data else { return .updateUserTownsFailed(error: .responseError)}
            
            let townName = data.selectedTown.townName
            
            return .userTownsUpdated(townName: townName)
        } catch let error as NetworkError {
            return .updateUserTownsFailed(error: error)
        } catch {
            return .updateUserTownsFailed(error: .unknownError)
        }
    }
}
