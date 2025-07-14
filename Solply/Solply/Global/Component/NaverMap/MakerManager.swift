//
//  MakerManager.swift
//  Solply
//
//  Created by 김승원 on 7/5/25.
//

import NMapsMap

/// 네이버 지도의 마커 이미지들을 관리하는 클래스
final class MarkerManager {
    private var markerImages: [MarkerType: (default: NMFOverlayImage, focused: NMFOverlayImage)] = [:]
    
    init() {
        MarkerType.allCases.forEach { markerType in
            let defaultImage = NMFOverlayImage(name: markerType.defaultImageName)
            let focusedImage = NMFOverlayImage(name: markerType.focusedImageName)
            markerImages[markerType] = (default: defaultImage, focused: focusedImage)
        }
    }
    
    /// 마커 타입과 상태에 따라 해당하는 마커 이미지를 반환합니다.
    ///
    /// - Parameters:
    ///   - type: 마커 순서 타입 (1번~6번)
    ///   - isFocused: 마커 상태 (true: 포커스/선택됨, false: 기본/선택안됨)
    /// - Returns: 요청된 마커 이미지 객체 (NMFOverlayImage)
    func getMarkerImage(for type: MarkerType, isFocused: Bool) -> NMFOverlayImage {
        let images = markerImages[type] ?? (default: NMFOverlayImage(), focused: NMFOverlayImage())
        return isFocused ? images.focused : images.default
    }
}
