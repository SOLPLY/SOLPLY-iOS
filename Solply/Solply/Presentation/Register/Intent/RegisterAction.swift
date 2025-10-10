//
//  RegisterAction.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import Foundation

enum RegisterAction {
    case updateSearchBarText(text: String)
    case selectPlaceToRegister(placeName: String, placeAddress: String?)
    
    case tempAction // 임시로 검색하는 action
    
    // api
    case errorOccured(error: NetworkError)
}
