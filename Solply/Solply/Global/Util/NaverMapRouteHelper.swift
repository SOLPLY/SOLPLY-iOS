//
//  NaverMapRouteHelper.swift
//  Solply
//
//  Created by 김승원 on 7/17/25.
//

import UIKit

enum NaverMapRouteHelper {
    static func findDirection(
        startLatitude: Double,
        startLongitude: Double,
        destinationLatitude: Double,
        destinationLongitude: Double,
        destinationName: String
    ) {
        let schemeURLString = "nmap://route/public?" +
        "sname=내 위치&slat=\(startLatitude)&slng=\(startLongitude)" +
        "&dname=\(destinationName)&dlat=\(destinationLatitude)&dlng=\(destinationLongitude)" +
        "&appname=\(Bundle.main.bundleIdentifier ?? "")"
        
        guard let encodedSchemeURLString = schemeURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let schemeURL = URL(string: encodedSchemeURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(schemeURL) {
            UIApplication.shared.open(schemeURL)
        } else {
            if let appStoreURL = URL(string: "https://apps.apple.com/app/id311867728") {
                UIApplication.shared.open(appStoreURL)
            }
        }
    }
}
