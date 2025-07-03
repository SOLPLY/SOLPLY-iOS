//
//  SolplyApp.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import SwiftUI

import NMapsMap

@main
struct SolplyApp: App {
    
    init() {
        NMFAuthManager.shared().ncpKeyId = AppEnvironment.naverMapClientId
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
