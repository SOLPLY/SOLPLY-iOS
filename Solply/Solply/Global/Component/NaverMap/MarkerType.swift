//
//  MarkerType.swift
//  Solply
//
//  Created by 김승원 on 7/5/25.
//

import Foundation

enum MarkerType: Int, CaseIterable {
    case first = 1
    case second = 2
    case third = 3
    case fourth = 4
    case fifth = 5
    case sixth = 6
    
    var defaultImageName: String {
        return "marker\(self.rawValue)-default-icon"
    }
    
    var focusedImageName: String {
        return "marker\(self.rawValue)-focused-icon"
    }
}
