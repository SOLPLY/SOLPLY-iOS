//
//  MyPageStore.swift
//  Solply
//
//  Created by sun on 9/19/25.
//

import Foundation

@MainActor
final class MyPageStore: ObservableObject {
    @Published private(set) var state = MyPageState()
    private let effect = MyPageEffect(
        userService: UserService(),
        placeService: PlaceService(),
        authService: AuthService()
    )

    func dispatch(_ action: MyPageAction) {
        MyPageReducer.reduce(state: &state, action: action)

        switch action {
        case .fetchMyPageContent(let userId):
            dispatch(.fetchMySolplyRecords)
            dispatch(.fetchRegisteredPlaces(userId: userId))

        case .fetchMySolplyRecords:
            Task {
                let result = await effect.fetchMySolplyRecords()
                dispatch(result)
            }

        case .fetchRegisteredPlaces(let userId):
            Task {
                let result = await effect.fetchRegisteredPlaces(userId: userId)
                dispatch(result)
            }

        case .fetchLoginInformation:
            Task {
                let result = await effect.fetchLoginInformation()
                dispatch(result)
            }
            
        case .logout:
            Task {
                let result = await effect.logout()
                dispatch(result)
            }

        default:
            break
        }
    }
}
