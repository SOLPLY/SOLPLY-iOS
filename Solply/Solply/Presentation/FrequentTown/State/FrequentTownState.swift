//
//  FrequentTownState.swift
//  Solply
//
//  Created by 선영주 on 7/15/25.
//

import Foundation

struct FrequentTownState {
    var selectedTown: Town? = nil
    var townList: [Town] = []
    var isSaving: Bool = false 
    var errorMessage: String? = nil
}
