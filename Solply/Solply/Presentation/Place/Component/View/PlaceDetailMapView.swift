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
    
    private var latitude: Double
    private var longitude: Double
    var addButtonSelected: Bool
    var bookmarkButtonSelected: Bool
    var bookmarkButtonEnabled: Bool
    var findDirectionEnabled: Bool
    
    private let zoomLevel: Double = 17
    private let contentInset: UIEdgeInsets = UIEdgeInsets(
        top: 0,
        left: 0,
        bottom: 430.adjustedHeight,
        right: 0
    )
    
    // MARK: - Init
    
    init(
        latitude: Double,
        longitude: Double,
        addButtonSelected: Bool,
        bookmarkButtonSelected: Bool,
        bookmarkButtonEnabled: Bool,
        findDirectionEnabled: Bool
    ) {
        self.latitude = latitude
        self.longitude = longitude
        self.addButtonSelected = addButtonSelected
        self.bookmarkButtonSelected = bookmarkButtonSelected
        self.bookmarkButtonEnabled = bookmarkButtonEnabled
        self.findDirectionEnabled = findDirectionEnabled
    }
    
    // MARK: - Functions
    
    func makeUIView(context: Context) -> NMFMapView {
        let mapView = configureMapView()
        return mapView
    }
    
    func updateUIView(_ mapView: NMFMapView, context: Context) {
        addMarker(to: mapView, context: context) // 조건 없이 무조건 호출
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
        mapView.positionMode = .disabled
        mapView.logoAlign = .rightTop
        mapView.logoInteractionEnabled = true
        return mapView
    }
    
    func configureCamera(_ mapView: NMFMapView) {
        DispatchQueue.main.async {
            let cameraUpdate = NMFCameraUpdate(
                scrollTo: NMGLatLng(lat: latitude, lng: longitude),
                zoomTo: zoomLevel
            )
            cameraUpdate.animation = .fly
            mapView.moveCamera(cameraUpdate)
        }
    }
    
    func addMarker(to mapView: NMFMapView, context: Context) {
        let marker = NMFMarker()
        marker.iconImage = NMFOverlayImage(name: "map-mark-place")
        marker.position = NMGLatLng(lat: latitude, lng: longitude)
        marker.width = 36.adjustedWidth
        marker.height = 36.adjustedHeight
        marker.anchor = CGPoint(x: 0.5, y: 1.0)
        marker.mapView = mapView
        context.coordinator.marker = marker
    }
}
