//
//  SolplyApp.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import SwiftUI

import KakaoSDKCommon
import KakaoSDKAuth
import NMapsMap

@main
struct SolplyApp: App {
    
    init() {
        // NaverMapSDK
        NMFAuthManager.shared().ncpKeyId = AppEnvironment.naverMapClientId
        
        // KAKAOSDK
        guard let kakaoNativeAppKey  = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String else {
            fatalError("KAKAO_NATIVE_APP_KEY가 Info.plist에 없습니다.")
        }
        
        KakaoSDK.initSDK(appKey: kakaoNativeAppKey)
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .onOpenURL { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}
