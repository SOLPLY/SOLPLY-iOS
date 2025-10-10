//
//  RegisterReducer.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import Foundation

enum RegisterReducer {
    static func reduce(state: inout RegisterState, action: RegisterAction) {
        switch action {
        case .updateSearchBarText(let text):
            state.placeName = text
            
        case .selectPlaceToRegister(let placeName, let placeAddress):
            state.placeName = placeName
            state.placeAddress = placeAddress
            state.registerStep = .selectMainTagType
            break
             
        case .errorOccured(let error):
            print(error)
            break
            
            
            
        case .tempAction: // 검색했다고 치고~
            state.searchResult = [
                RegisterSearch(
                    placeName: "공간 이름1이이이이이이이이이이이ㅣ이이이이이이이이이",
                    placeAddress: "상세 주소 1 아아아아아아아아아아아아아아아ㅏ앙아아"
                ),
                RegisterSearch(
                    placeName: "공간 이름2",
                    placeAddress: "상세 주소2"
                ),
                RegisterSearch(
                    placeName: "공간 이름3",
                    placeAddress: "상세 주소3"
                )
            ]
        }
    }
}
