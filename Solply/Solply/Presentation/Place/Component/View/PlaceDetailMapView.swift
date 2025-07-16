//
//  PlaceDetailMapView.swift
//  Solply
//
//  Created by 김승원 on 7/14/25.
//

import SwiftUI

import NMapsMap

struct PlaceDetailMapView: UIViewRepresentable {
    
    // MARK: - Properties
    
    private let place: PlaceDetail
    private let zoomLevel: Double = 16
    private let contentInset: UIEdgeInsets = UIEdgeInsets(
        top: 0,
        left: 0,
        bottom: 540.adjustedHeight,
        right: 0
    )
    
    // MARK: - Init
    
    init(place: PlaceDetail) {
        self.place = place
    }
    
    // MARK: - Functions
    
    func makeUIView(context: Context) -> NMFMapView {
        let mapView = configureMapView()
        configureCamera(mapView)
//        addMarker(to: mapView, context: context)
        return mapView
    }
    
    func updateUIView(_ mapView: NMFMapView, context: Context) {
        // 마커가 없는 경우에만 추가
        if context.coordinator.marker == nil {
            addMarker(to: mapView, context: context)
        }
        
        // 항상 카메라 위치는 업데이트
        configureCamera(mapView)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}

// MARK: - Coordinator

extension PlaceDetailMapView {
    class Coordinator {
        var marker: NMFMarker?
    }
}

// MARK: - Helpers

private extension PlaceDetailMapView {
    
    func configureMapView() -> NMFMapView {
        let mapView = NMFMapView()
        mapView.mapType = .basic
        mapView.setLayerGroup(NMF_LAYER_GROUP_BUILDING, isEnabled: true)
        mapView.isIndoorMapEnabled = false
        mapView.contentInset = contentInset
        mapView.isZoomGestureEnabled = true
        mapView.positionMode = .normal
        mapView.logoAlign = .rightTop
        mapView.logoInteractionEnabled = true
        return mapView
    }
    
    func configureCamera(_ mapView: NMFMapView) {
        DispatchQueue.main.async {
            let cameraUpdate = NMFCameraUpdate(
                scrollTo: NMGLatLng(lat: place.latitude, lng: place.longitude),
                zoomTo: zoomLevel
            )
            cameraUpdate.animation = .fly
            mapView.moveCamera(cameraUpdate)
        }
    }
    
    func addMarker(to mapView: NMFMapView, context: Context) {
        let marker = NMFMarker()
        marker.iconImage = NMFOverlayImage(name: "map-mark-place")
        marker.position = NMGLatLng(lat: place.latitude, lng: place.longitude)
        marker.width = 36.adjustedWidth
        marker.height = 36.adjustedHeight
        marker.anchor = CGPoint(x: 0.5, y: 0.5)
        marker.mapView = mapView
        context.coordinator.marker = marker
    }
}
