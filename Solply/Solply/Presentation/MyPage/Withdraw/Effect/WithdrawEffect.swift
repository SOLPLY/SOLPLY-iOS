//
//  WithdrawEffect.swift
//  Solply
//
//  Created by LEESOOYONG on 10/11/25.
//

import Foundation

struct WithdrawEffect {
    private let userService: UserAPI
    
    init(userService: UserAPI) {
        self.userService = userService
    }
    
    func withdraw(withdrawReason: String, reasonText: String) async ->
    WithdrawAction {
        do {
            let _ = try await
            userService.withdraw(request: .init(
                withdrawReason: withdrawReason,
                reasonText: reasonText
            ))
            return .withdrawSuccess
        } catch let error as NetworkError {
            return .withdrawFailed(error: error)
        } catch {
            return .withdrawFailed(error: .unknownError)
        }
    }
}
