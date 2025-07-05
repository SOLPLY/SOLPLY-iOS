//
//  NMapView.swift
//  Solply
//
//  Created by 김승원 on 7/3/25.
//

import SwiftUI

import NMapsMap

/// 네이버 지도를 SwiftUI에서 사용하기 위한 뷰입니다.
struct NMapView: UIViewRepresentable {
    
    // MARK: - Properties
    
    private var coordinate: (Double, Double)
    
    init(coordinate: (Double, Double)) {
        self.coordinate = coordinate
    }
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        let mapView = NMFNaverMapView()
        mapView.showZoomControls = false
        mapView.mapView.positionMode = .disabled
        mapView.mapView.zoomLevel = 17 // 수정 필요
        
        let targetCoord = NMGLatLng(lat: coordinate.1, lng: coordinate.0)
        let cameraUpdate = NMFCameraUpdate(scrollTo: targetCoord)
        cameraUpdate.animation = .none
        mapView.mapView.moveCamera(cameraUpdate)
        
        return mapView
    }
    
    func updateUIView(_ mapView: NMFNaverMapView, context: Context) {
        let coordinate = NMGLatLng(lat: coordinate.1, lng: coordinate.0)
        let cameraUpdate = NMFCameraUpdate(scrollTo: coordinate)
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 1
        mapView.mapView.moveCamera(cameraUpdate)
    }
}
