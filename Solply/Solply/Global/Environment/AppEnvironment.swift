//
//  AppEnvironment.swift
//  Solply
//
//  Created by 김승원 on 7/3/25.
//

import Foundation


enum AppEnvironment {
    static let naverMapClientId: String = {
        guard let clientId = Bundle.main.object(forInfoDictionaryKey: "NMFClientId") as? String else {
            fatalError("Info.plist에 NMFClientId가 없습니다.")
        }
        
        return clientId
    }()
}
