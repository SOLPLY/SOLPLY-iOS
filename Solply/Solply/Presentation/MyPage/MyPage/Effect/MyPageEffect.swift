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
    private let placeService: PlaceAPI
    private let authService: AuthService
    
    // MARK: - Init
    
    init(userService: UserAPI, placeService: PlaceAPI, authService: AuthService) {
        self.userService = userService
        self.placeService = placeService
        self.authService = authService
    }
}

// MARK: - My Page Content

extension MyPageEffect {
    func fetchMySolplyRecords() async -> MyPageAction {
        do {
            let response = try await placeService.fetchMySolplyRecords()

            guard let data = response.data else {
                return .fetchMySolplyRecordsFailed(error: .responseError)
            }

            return .mySolplyRecordsFetched(
                records: data.reviews.map(MySolplyRecord.init),
                totalCount: data.reviewCount
            )
        } catch let error as NetworkError {
            return .fetchMySolplyRecordsFailed(error: error)
        } catch {
            return .fetchMySolplyRecordsFailed(error: .unknownError)
        }
    }

    func fetchRegisteredPlaces(userId: Int) async -> MyPageAction {
        do {
            let response = try await userService.fetchRegisteredPlaces(
                userId: userId,
                page: 0,
                size: 100
            )

            guard let data = response.data else {
                return .fetchRegisteredPlacesFailed(error: .responseError)
            }

            return .registeredPlacesFetched(data.content.map(RegisteredPlace.init))
        } catch let error as NetworkError {
            return .fetchRegisteredPlacesFailed(error: error)
        } catch {
            return .fetchRegisteredPlacesFailed(error: .unknownError)
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
    
    func logout() async -> MyPageAction {
        do {
            _ = try await authService.logout()
            
            return .logoutSuccess
            
        } catch let error as NetworkError {
            return .logoutFailed(error: error)
        } catch {
            return .logoutFailed(error: .unknownError)
        }
    }
}
