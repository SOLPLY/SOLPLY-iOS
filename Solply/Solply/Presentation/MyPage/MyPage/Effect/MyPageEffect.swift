//
//  MyPageEffect.swift
//  Solply
//
//  Created by sun on 11/9/25.
//

import Foundation

struct MyPageEffect {
    
    // MARK: - Properties
    
    private let userService: UserAPI
    
    // MARK: - Init
    
    init(userService: UserAPI) {
        self.userService = userService
    }
    
    // MARK: - Functions
    
    func fetchUser() async -> MyPageAction? {
        do {
            let response = try await userService.fetchUserInformation()
            
            guard let dto = response.data else { return nil }
            let user = UserInformation(dto: dto)
            return .userLoaded(user)
        } catch {
            return nil
        }
    }

    func fetchRegisteredPlaces(
        userId: Int,
        page: Int = 1,
        size: Int = 3
    ) async -> MyPageAction? {
        do {
            let response = try await userService.fetchRegisteredPlaces(
                userId: userId,
                page: page,
                size: size
            )
            guard let dto = response.data else { return nil }

            let places = dto.places.map(UserPlace.init(dto:))
            return .registeredPlacesLoaded(places)

        } catch {
            return nil
        }
    }
}
