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
        page: Int = 0,
        size: Int = 100
    ) async -> RegisteredPlacesAction {
        do {
            let response = try await userService.fetchRegisteredPlaces(
                userId: userId,
                page: page,
                size: size
            )
            
            guard let dto = response.data else {
                return .registeredPlacesLoadFailed(error: .responseError)
            }
            
            let places = dto.places.map(RegisteredPlace.init)
            return .registeredPlacesLoaded(places)
            
        } catch let error as NetworkError {
            return .registeredPlacesLoadFailed(error: error)
        } catch {
            return .registeredPlacesLoadFailed(error: .unknownError)
        }
    }
}
