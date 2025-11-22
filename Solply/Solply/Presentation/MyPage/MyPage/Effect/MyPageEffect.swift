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
    private let authService: AuthService
    
    // MARK: - Init
    
    init(userService: UserAPI, authService: AuthService) {
        self.userService = userService
        self.authService = authService
    }
    
    // MARK: - Functions
    
    func fetchUser() async -> MyPageAction {
        do {
            let response = try await userService.fetchUserInformation()
            
            guard let dto = response.data else {
                return .userLoadFailed(error: .responseError)
            }
            
            let user = UserInformation(dto: dto)
            return .userLoaded(user)
            
        } catch let error as NetworkError {
            return .userLoadFailed(error: error)
        } catch {
            return .userLoadFailed(error: .unknownError)
        }
    }

    func fetchRegisteredPlaces(
        userId: Int,
        page: Int = 1,
        size: Int = 3
    ) async -> MyPageAction {
        do {
            let response = try await userService.fetchRegisteredPlaces(
                userId: userId,
                page: page,
                size: size
            )
            
            guard let dto = response.data else {
                return .registeredPlacesLoadFailed(error: .responseError)
            }
            
            let places = dto.places.map(UserPlace.init)
            return .registeredPlacesLoaded(places)
            
        } catch let error as NetworkError {
            return .registeredPlacesLoadFailed(error: error)
        } catch {
            return .registeredPlacesLoadFailed(error: .unknownError)
        }
    }
}

 // MARK: - AuthAPI

extension MyPageEffect {
    func fetchLoginInformation() async -> MyPageAction {
        do {
            let response = try await authService.fetchLoginInformation()
            
            guard let data = response.data else {
                return .fetchLoginInformationFailed(error: .responseError)
            }
            
            let loginInformation = SocialLoginType(rawValue: data.socialPlatform)
            return .fetchLoginInformationSuccess(loginInformation: loginInformation)
            
        } catch let error as NetworkError {
            return .fetchLoginInformationFailed(error: error)
        } catch {
            return .fetchLoginInformationFailed(error: .unknownError)
        }
    }
}
