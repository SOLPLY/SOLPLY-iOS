//
//  TownOptionType.swift
//  Solply
//
//  Created by 선영주 on 7/11/25.
//

import SwiftUI

enum TownOptionType: Hashable, CaseIterable {
    case named(String)
    case add

    static var allCases: [TownOptionType] {
        return [
            .named("망원동"),
            .named("연희동"),
            .add
        ]
    }

    var title: String? {
        switch self {
        case .named(let name):
            return name
        case .add:
            return nil
        }
    }

    func backgroundColor(isSelected: Bool) -> Color {
        switch self {
        case .named:
            return isSelected ? .red100 : .gray100
        case .add:
            return .gray200
        }
    }

    func borderColor(isSelected: Bool) -> Color {
        switch self {
        case .named:
            return isSelected ? .red300 : .gray300
        case .add:
            return .gray200
        }
    }
}
