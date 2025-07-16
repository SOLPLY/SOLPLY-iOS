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
    case large
    case extraLarge
    case huge
    case extraHuge
    case mega
    case world
    case galaxy   // 새로 추가

    var zoom: Double {
        switch self {
        case .micro: return 17.5
        case .small: return 17.0
        case .medium: return 16.5
        case .large: return 16.0
        case .extraLarge: return 15.5
        case .huge: return 15.0
        case .extraHuge: return 14.5
        case .mega: return 14.0
        case .world: return 13.5
        case .galaxy: return 12.5  // world(13.5)보다 더 멀리
        }
    }

    var coordinateDelta: (latitude: Double, longitude: Double) {
        switch self {
        case .micro: return (latitude: 0.0007, longitude: 0.0014)
        case .small: return (latitude: 0.001, longitude: 0.002)
        case .medium: return (latitude: 0.0015, longitude: 0.003)
        case .large: return (latitude: 0.002, longitude: 0.004)
        case .extraLarge: return (latitude: 0.003, longitude: 0.006)
        case .huge: return (latitude: 0.004, longitude: 0.008)
        case .extraHuge: return (latitude: 0.0055, longitude: 0.011)
        case .mega: return (latitude: 0.007, longitude: 0.014)
        case .world: return (latitude: 0.01, longitude: 0.02)
        case .galaxy: return (latitude: 0.015, longitude: 0.03) // 더 크게
        }
    }
}
