//
//  WithdrawStore.swift
//  Solply
//
//  Created by LEESOOYONG on 10/11/25.
//

import Foundation

@MainActor
final class WithdrawStore: ObservableObject {
    @Published private(set) var state = WithdrawState()
    private let effect : WithdrawEffect =  WithdrawEffect(userService: UserService())
    
    func dispatch(_ action: WithdrawAction) {
        WithdrawReducer.reduce(state: &state, action: action)
        
        switch action {
        case .withdraw:
            Task {
                guard let type = state.selectedWithdrawType else { return }

                let withdrawReason = type.rawValue
                let reasonText: String
                if type == .others {
                    reasonText = state.withdrawContent 
                } else {
                    reasonText = type.title
                }

                let result = await effect.withdraw(
                    withdrawReason: withdrawReason,
                    reasonText: reasonText
                )
                self.dispatch(result)
            }
        
        default:
            break
        }
    }
}
