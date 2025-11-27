//
//  UserWithdrawRequestDTO.swift
//  Solply
//
//  Created by LEESOOYONG on 11/25/25.
//

import Foundation

struct UserWithdrawRequestDTO: RequestModelType {
    let withdrawReason: String   
    let reasonText: String
}
