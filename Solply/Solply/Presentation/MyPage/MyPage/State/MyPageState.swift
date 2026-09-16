//
//  MyPageState.swift
//  Solply
//
//  Created by sun on 9/19/25.
//

import Foundation

struct MyPageState {
    var error: NetworkError?
    var loginInformation: SocialLoginType?
    var mySolplyRecords: [MySolplyRecord] = []
    var mySolplyRecordCount: Int = 0
    var registeredPlaces: [RegisteredPlace] = []

    var shouldChangeRoot: Bool = false
}
