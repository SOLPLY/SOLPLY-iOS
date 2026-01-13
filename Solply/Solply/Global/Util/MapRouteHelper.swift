//
//  MapRouteHelper.swift
//  Solply
//
//  Created by 김승원 on 7/17/25.
//

import UIKit

enum MapRouteHelper {

    // MARK: - FindDirection

    static func findDirection(
        with mapRouteType: MapRouteType,
        startLatitude: Double,
        startLongitude: Double,
        destinationLatitude: Double,
        destinationLongitude: Double,
        destinationName: String?
    ) {
        switch mapRouteType {
        case .naver:
            guard let destinationName,
                  let url = naverUrl(
                    startLatitude: startLatitude,
                    startLongitude: startLongitude,
                    destinationLatitude: destinationLatitude,
                    destinationLongitude: destinationLongitude,
                    destinationName: destinationName
                  )
            else { return }

            open(
                url: url,
                appStoreURL: URL(string: "itms-apps://itunes.apple.com/app/id311867728")
            )

        case .apple:
            guard let url = appleUrl(
                startLatitude: startLatitude,
                startLongitude: startLongitude,
                destinationLatitude: destinationLatitude,
                destinationLongitude: destinationLongitude
            ) else { return }

            open(
                url: url,
                appStoreURL: URL(string: "itms-apps://itunes.apple.com/app/id915056765")
            )

        case .kakao:
            guard let url = kakaoUrl(
                startLatitude: startLatitude,
                startLongitude: startLongitude,
                destinationLatitude: destinationLatitude,
                destinationLongitude: destinationLongitude
            ) else { return }

            open(
                url: url,
                appStoreURL: URL(string: "itms-apps://itunes.apple.com/app/id304608425")
            )
        }
    }
}

// MARK: - URL Builders

private extension MapRouteHelper {

    static func naverUrl(
        startLatitude: Double,
        startLongitude: Double,
        destinationLatitude: Double,
        destinationLongitude: Double,
        destinationName: String
    ) -> URL? {
        let urlString = """
        nmap://route/public?\
        sname=내 위치&slat=\(startLatitude)&slng=\(startLongitude)\
        &dname=\(destinationName)&dlat=\(destinationLatitude)&dlng=\(destinationLongitude)\
        &appname=\(Bundle.main.bundleIdentifier ?? "")
        """

        return urlString
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            .flatMap(URL.init)
    }

    static func appleUrl(
        startLatitude: Double,
        startLongitude: Double,
        destinationLatitude: Double,
        destinationLongitude: Double
    ) -> URL? {
        let urlString = "maps://?saddr=\(startLatitude),\(startLongitude)&daddr=\(destinationLatitude),\(destinationLongitude)&dirflg=d"

        return URL(string: urlString)
    }

    static func kakaoUrl(
        startLatitude: Double,
        startLongitude: Double,
        destinationLatitude: Double,
        destinationLongitude: Double
    ) -> URL? {
        let urlString = "kakaomap://route?sp=\(startLatitude),\(startLongitude)&ep=\(destinationLatitude),\(destinationLongitude)&by=publictransit"

        return URL(string: urlString)
    }
}

// MARK: - Open Helper

private extension MapRouteHelper {

    static func open(url: URL, appStoreURL: URL?) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else if let appStoreURL {
            UIApplication.shared.open(appStoreURL)
        }
    }
}
