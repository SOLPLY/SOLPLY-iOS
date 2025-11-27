//
//  WithdrawState.swift
//  Solply
//
//  Created by LEESOOYONG on 10/11/25.
//

import Foundation

struct WithdrawState {
    var selectedWithdrawType: WithdrawType?
    var withdrawContent: String = ""
    var shouldChangeRoot: Bool = false
    var error: NetworkError?
    var isPresented: Bool = false
}
