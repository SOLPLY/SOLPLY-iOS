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
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.mapView.positionMode = .disabled
        view.mapView.zoomLevel = 17 // 수정 필요
        
        return view
    }
    
    func updateUIView(_ view: NMFNaverMapView, context: Context) {
        let coordinate = NMGLatLng(lat: coordinate.1, lng: coordinate.0)
        let cameraUpdate = NMFCameraUpdate(scrollTo: coordinate)
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 1
        view.mapView.moveCamera(cameraUpdate)
    }
}
