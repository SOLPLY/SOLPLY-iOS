//
//  RegisteredPlacesEffect.swift
//  Solply
//
//  Created by seozero on 11/19/25.
//

import Foundation

struct RegisteredPlacesEffect {
    
    // MARK: - Properties
    
    private let userService: UserAPI
    
    // MARK: - Initializer
    
    init(userService: UserAPI) {
        self.userService = userService
    }
    
    // MARK: - Functions
    
    func fetchRegisteredPlaces(
        userId: Int,
        page: Int,
        size: Int
    ) async -> RegisteredPlacesAction {
        do {
            let response = try await userService.fetchRegisteredPlaces(
                userId: userId,
                page: page,
                size: size
            )
            
            guard let data = response.data else {
                return .fetchRegisteredPlacesFailed(error: .responseError)
            }
            
            let places = data.content.map { RegisteredPlace(dto: $0) }
            
            return .registeredPlacesFetched(places)
            
        } catch let error as NetworkError {
            return .fetchRegisteredPlacesFailed(error: error)
        } catch {
            return .fetchRegisteredPlacesFailed(error: .unknownError)
        }
    }
}
