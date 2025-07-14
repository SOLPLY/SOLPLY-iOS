//
//  PlaceDetailAction.swift
//  Solply
//
//  Created by 김승원 on 7/4/25.
//

import Foundation

enum PlaceDetailAction {
    case toggleAddToCourse
    case toggleSavePlace
    case requestFindDirection
    
    case selectCourseToAdd(index: Int)
    case addPlaceToCourse(index: Int)
    
    case showToastView(ToastContent)
}
