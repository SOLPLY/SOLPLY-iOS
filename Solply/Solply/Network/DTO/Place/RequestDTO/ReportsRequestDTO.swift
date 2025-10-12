//
//  ReportsRequestDTO.swift
//  Solply
//
//  Created by 김승원 on 10/11/25.
//

import Foundation

struct ReportsRequestDTO: RequestModelType {
    let reportsType: String
    let content: String
    let imageKeys: [String]
}
