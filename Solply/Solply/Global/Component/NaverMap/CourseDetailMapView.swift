//
//  NMapView.swift
//  Solply
//
//  Created by 김승원 on 7/3/25.
//

import SwiftUI

import NMapsMap

/// 네이버 지도를 SwiftUI에서 사용하기 위한 뷰입니다.
struct CourseDetailMapView: UIViewRepresentable {
    
    // MARK: - Properties
    
    private let markerManager = MarkerManager()
    private var places: [Place]
    
    private let contentInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 440.adjustedHeight, right: 0)
    
    private let defaultMarkerWidth: CGFloat = 36.adjustedWidth
    private let defaultMarkerHeight: CGFloat = 36.adjustedHeight
    private let focusedMarkerWidth: CGFloat = 42.adjustedWidth
    private let focusedMarkerHeight: CGFloat = 42.adjustedHeight
    
    private let defaultZoomLevel: Double = ZoomLevel.extraLarge.zoom
    
    // MARK: - Initializer

    init(places: [Place]) {
        self.places = places
    }
    
    func makeUIView(context: Context) -> NMFMapView {
        let mapView = configureMapView(context: context)
        configureInitialCamera(mapView)
        return mapView
    }
    
    func updateUIView(_ mapView: NMFMapView, context: Context) {
        clearMapContent(mapView, context: context)

        guard !places.isEmpty else { return }

        addMarkersToMap(mapView, context: context)
        addLineToMap(mapView, context: context)
        updateCameraWithCalculatedZoom(mapView)
    }
}

// MARK: - Map Configuration

extension CourseDetailMapView {
    /// 지도를 초기화하는 함수입니다.
    private func configureMapView(context: Context) -> NMFMapView {
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
    
    /// 기존 지도 컨텐츠를 제거하는 함수입니다.
    private func clearMapContent(_ mapView: NMFMapView, context: Context) {
        let coordinator = context.coordinator
            coordinator.markers.forEach { $0.mapView = nil }
            coordinator.markers.removeAll()

            coordinator.polyline?.mapView = nil
            coordinator.polyline = nil
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

}

// MARK: - Camera Management

extension CourseDetailMapView {
    /// 초기 카메라 위치를 설정하는 함수입니다 (기본 줌 레벨 15.5).
    private func configureInitialCamera(_ mapView: NMFMapView) {
        let centerCoordinate: NMGLatLng
        
        if places.isEmpty {
            centerCoordinate = NMGLatLng(lat: 37.5665, lng: 126.9780)
        } else {
            centerCoordinate = calculateCenterCoordinate()
        }
        
        DispatchQueue.main.async {
            let cameraUpdate = NMFCameraUpdate(scrollTo: centerCoordinate, zoomTo: self.defaultZoomLevel)
            cameraUpdate.animation = .easeOut
            mapView.moveCamera(cameraUpdate)
        }
    }
    
    /// 계산된 줌 레벨로 카메라를 업데이트하는 함수입니다.
    private func updateCameraWithCalculatedZoom(_ mapView: NMFMapView) {
        let centerCoordinate = calculateCenterCoordinate()
        let calculatedZoomLevel = calculateOptimalZoomLevel()
        
        DispatchQueue.main.async {
            let cameraUpdate = NMFCameraUpdate(scrollTo: centerCoordinate, zoomTo: calculatedZoomLevel)
            cameraUpdate.animation = .easeIn
            mapView.moveCamera(cameraUpdate)
        }
    }
    
    /// 코스 내 장소들의 중앙 좌표를 구하는 함수입니다.
    private func calculateCenterCoordinate() -> NMGLatLng {
        let boundingBox = calculateBoundingBox()
        let centerLatitude = (boundingBox.minLatitude + boundingBox.maxLatitude) / 2
        let centerLongitude = (boundingBox.minLongitude + boundingBox.maxLongitude) / 2
        let centerCoordinate = NMGLatLng(lat: centerLatitude, lng: centerLongitude)
        return centerCoordinate
    }
    
    /// bounding box를 구하는 함수입니다.
    private func calculateBoundingBox() -> BoundingBox {
        guard !places.isEmpty else {
            return BoundingBox(
                minLatitude: 37.5665,
                maxLatitude: 37.5665,
                minLongitude: 126.9780,
                maxLongitude: 126.9780
            )
        }
        
        var minLatitude = places[0].latitude // 가장 남쪽
        var maxLatitude = places[0].latitude // 가장 북쪽
        var minLongitude = places[0].longitude // 가장 서쪽
        var maxLongitude = places[0].longitude // 가장 동쪽
        
        for place in places {
            minLatitude = min(minLatitude, place.latitude)
            maxLatitude = max(maxLatitude, place.latitude)
            minLongitude = min(minLongitude, place.longitude)
            maxLongitude = max(maxLongitude, place.longitude)
        }
        
        let boundingBox = BoundingBox(
            minLatitude: minLatitude,
            maxLatitude: maxLatitude,
            minLongitude: minLongitude,
            maxLongitude: maxLongitude
        )
        
        return boundingBox
    }
    
    /// 마커 분포에 따라 최적의 줌 레벨을 계산하는 함수입니다.
    private func calculateOptimalZoomLevel() -> Double {
        guard !places.isEmpty else { return defaultZoomLevel }
        
        let boundingBox = calculateBoundingBox()
        let latitudeRange = boundingBox.maxLatitude - boundingBox.minLatitude
        let longitudeRange = boundingBox.maxLongitude - boundingBox.minLongitude
        
        for level in ZoomLevel.allCases {
            let coordinateDelta = level.coordinateDelta
            
            print("--------\(level.zoom)-\(level)------------")
            print("마커 범위 - 위도: \(latitudeRange), 경도: \(longitudeRange)")
            print("레벨 범위 - 위도: \(coordinateDelta.latitude), 경도: \(coordinateDelta.longitude)")
            print("--------------계산 끝--------------")
            
            // 마커들의 범위가 현재 레벨의 coordinateDelta 안에 들어가는지 확인
            if latitudeRange <= coordinateDelta.latitude && longitudeRange <= coordinateDelta.longitude {
                print("선택된 줌 레벨: \(level.zoom)")
                return level.zoom
            }
        }
        
        print("기본 줌 레벨: \(ZoomLevel.extraLarge.zoom)")
        return ZoomLevel.extraLarge.zoom
    }
    
    /// 특정 장소로 카메라 이동하는 함수입니다.
    private func moveCameraToPlace(_ place: Place, mapView: NMFMapView, animated: Bool = true) {
        let coordinate = NMGLatLng(lat: place.latitude, lng: place.longitude)
        let cameraUpdate = NMFCameraUpdate(scrollTo: coordinate)
        cameraUpdate.animation = animated ? .easeIn : .none
        mapView.moveCamera(cameraUpdate)
    }
}

// MARK: - Marker Management

extension CourseDetailMapView {
    /// 지도에 마커를 추가하는 함수입니다.
    private func addMarkersToMap(_ mapView: NMFMapView, context: Context) {
        let coordinator = context.coordinator
        
        DispatchQueue.global(qos: .default).async {
            var markers: [NMFMarker] = []
  
            for (index, place) in self.places.enumerated() {
                guard let markerType = MarkerType(rawValue: index + 1) else { continue }
                
                let marker = NMFMarker()
                marker.position = NMGLatLng(lat: place.latitude, lng: place.longitude)
                marker.iconImage = self.markerManager.getMarkerImage(for: markerType, isFocused: place.isFocused)
                marker.width = place.isFocused ? self.focusedMarkerWidth : self.defaultMarkerWidth
                marker.height = place.isFocused ? self.focusedMarkerHeight : self.defaultMarkerHeight
                marker.anchor = CGPoint(x: 0.5, y: 0.5)
                marker.zIndex = self.places.count - index
                markers.append(marker)
            }

            DispatchQueue.main.async {
                for marker in markers {
                    marker.mapView = mapView
                }
            }
            
            coordinator.markers = markers
        }
    }
    
    /// 지도에 코스(선)을 추가하는 함수입니다.
    private func addLineToMap(_ mapView: NMFMapView, context: Context) {
        let coordinator = context.coordinator
        
        guard places.count > 1 else { return }
        
        var coordinates: [NMGLatLng] = []
        
        for place in places {
            let coordinate = NMGLatLng(lat: place.latitude, lng: place.longitude)
            coordinates.append(coordinate)
        }
        
        let polyline = NMFPolylineOverlay(coordinates)
        polyline?.width = 2
        polyline?.color = .purple900
        polyline?.mapView = mapView
        
        coordinator.polyline = polyline
    }
}

class Coordinator {
    var markers: [NMFMarker] = []
    var polyline: NMFPolylineOverlay?
}
