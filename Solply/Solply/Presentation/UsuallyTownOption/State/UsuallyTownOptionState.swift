//
//  UsuallyTownOptionState.swift
//  Solply
//
//  Created by 선영주 on 7/15/25.
//

import Foundation

struct UsuallyTownOptionState {
    var selectedOption: TownOptionType
    var isUserSelected: Bool
    
    init(initialOption: TownOptionType) {
        self.selectedOption = initialOption
        self.isUserSelected = false
    }
}
