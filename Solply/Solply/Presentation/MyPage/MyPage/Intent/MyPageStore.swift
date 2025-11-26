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
