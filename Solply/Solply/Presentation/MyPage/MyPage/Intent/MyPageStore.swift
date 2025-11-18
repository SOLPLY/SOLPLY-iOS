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
        authService: AuthService()
    )

    func dispatch(_ action: MyPageAction) {
        MyPageReducer.reduce(state: &state, action: action)

        switch action {
            
        case .fetchUser:
            Task {
                let result = await effect.fetchUser()
                dispatch(result)
            }

        case let .fetchRegisteredPlaces(userId, page, size):
            Task {
                let result = await effect.fetchRegisteredPlaces(userId: userId, page: page, size: size)
                dispatch(result)
            }

        case let .userLoaded(user):
            Task {
                let result = await effect.fetchRegisteredPlaces(userId: user.userId)
                dispatch(result)
            }

        default:
            break
        }
    }
}
