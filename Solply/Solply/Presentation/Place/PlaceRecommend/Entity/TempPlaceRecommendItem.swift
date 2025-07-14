//
//  TempPlaceRecommendItem.swift
//  Solply
//
//  Created by seozero on 7/14/25.
//

import Foundation

struct TempPlaceRecommendItem: Identifiable, Equatable {
    let id: Int
    let category: PlaceCategoryType
    let title: String
    let description: String
}
