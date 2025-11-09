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
    private let effect = MyPageEffect(userService: UserService())

    func dispatch(_ action: MyPageAction) {
        switch action {
        case .fetchUser:
            Task {
                if let result = await effect.fetchUser() {
                    dispatch(result)
                }
            }

        case let .fetchRegisteredPlaces(userId, page, size):
            Task {
                if let result = await effect.fetchRegisteredPlaces(userId: userId, page: page, size: size) {
                    dispatch(result)                }
            }

        case let .userLoaded(user):
            MyPageReducer.reduce(state: &state, action: .userLoaded(user))
            Task {
                if let result = await effect.fetchRegisteredPlaces(userId: user.userId) {
                    dispatch(result)
                }
            }

        case .registeredPlacesLoaded,
             .editProfileTapped, .customerCenterTapped, .logoutTapped, .deleteAccountTapped:
            MyPageReducer.reduce(state: &state, action: action)
        }
    }
}
