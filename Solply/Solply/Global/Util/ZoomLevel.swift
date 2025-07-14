//
//  ZoomLevel.swift
//  Solply
//
//  Created by 김승원 on 7/6/25.
//

import Foundation

import NMapsMap

enum ZoomLevel: CaseIterable {
    case micro
    case small
    case medium
    case Large
    case extraLarge
    
    var zoom: Double {
        switch self {
        case .micro: return 17.5
        case .small: return 17.0
        case .medium: return 16.5
        case .Large: return 16.0
        case .extraLarge: return 15.5
        }
    }
    
    // 상대적 범위값 (위도차이, 경도차이)
    var coordinateDelta: (latitude: Double, longitude: Double) {
        switch self {
        case .micro: return (latitude: 0.0007, longitude: 0.0014)
        case .small: return (latitude: 0.001, longitude: 0.002)
        case .medium: return (latitude: 0.0015, longitude: 0.003)
        case .Large: return (latitude: 0.002, longitude: 0.004)
        case .extraLarge: return (latitude: 0.003, longitude: 0.006)
        }
    }
}
