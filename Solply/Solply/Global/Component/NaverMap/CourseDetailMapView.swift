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
    private var course: Course
    
    private let contentInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 440.adjustedHeight, right: 0)
    
    private let markerWidth: CGFloat = 36.adjustedWidth
    private let markerHeight: CGFloat = 36.adjustedHeight
    
    // MARK: - Initializer

    init(course: Course) {
        self.course = course
    }
    
    func makeUIView(context: Context) -> NMFMapView {
        let mapView = configureMapView(context: context)
        configureCamera(mapView)
        addMarkesToMap(mapView)
        calculateZoomLevel(mapView)
        return mapView
    }
    
    func updateUIView(_ mapView: NMFMapView, context: Context) {
        
    }
}

// MARK: - Map Configuration

extension CourseDetailMapView {
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
}

// MARK: - Camera Management

extension CourseDetailMapView {
    /// 초기 카메라 위치를 설정하는 함수
    private func configureCamera(_ mapView: NMFMapView) {
        DispatchQueue.main.async {
            let centerCoordinate = calculateCenterCoordinate()
            let cameraUpdate = NMFCameraUpdate(scrollTo: centerCoordinate)
            cameraUpdate.animation = .none
            mapView.moveCamera(cameraUpdate)
        }
    }
    
    /// 코스 내 장소들의 중앙 좌표를 구하는 함수
    private func calculateCenterCoordinate() -> NMGLatLng {
        let boundingBox = calculateBoundingBox()
        let centerLatitude = (boundingBox.minLatitude + boundingBox.maxLatitude) / 2
        let centerLongitude = (boundingBox.minLongitude + boundingBox.maxLongitude) / 2
        let centerCoordinate = NMGLatLng(lat: centerLatitude, lng: centerLongitude)
        return centerCoordinate
    }
    
    /// bounding box를 구하는 함수입니다.
    private func calculateBoundingBox() -> BoundingBox {
        guard !course.places.isEmpty else {
            return BoundingBox(
                minLatitude: 0,
                maxLatitude: 0,
                minLongitude: 0,
                maxLongitude: 0
            )
        }
        
        // 첫 번째 장소로 초기화
        var minLatitude = course.places[0].latitude // 가장 남쪽
        var maxLatitude = course.places[0].latitude // 가장 북쪽
        var minLongitude = course.places[0].longitude // 가장 서쪽
        var maxLongitude = course.places[0].longitude // 가장 동쪽
        
        // 모든 장소를 순회하면서 최솟값/최댓값 찾기
        for place in course.places {
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
    
    /// 마커 분포에 따라(BoundingBox를 기준으로) 줌 레벨을 계산하는 함수
    private func calculateZoomLevel(_ mapView: NMFMapView) {
        let boundingBox = calculateBoundingBox()
        
        // 마커들의 실제 분포 범위 계산
        let latitudeRange = boundingBox.maxLatitude - boundingBox.minLatitude
        let longitudeRange = boundingBox.maxLongitude - boundingBox.minLongitude
        
        for level in ZoomLevel.allCases {
            let coordinateDelta = level.coordinateDelta
            
            print("--------\(level.zoom)-\(level)------------")
            print("마커 범위 - 위도: \(latitudeRange), 경도: \(longitudeRange)")
            print("레벨 범위 - 위도: \(coordinateDelta.latitude), 경도: \(coordinateDelta.longitude)")
            print("----------Rrr------------------")
            
            // 마커들의 범위가 현재 레벨의 span 안에 들어가는지 확인
            if latitudeRange <= coordinateDelta.latitude && longitudeRange <= coordinateDelta.longitude {
                mapView.zoomLevel = level.zoom
                print("선택된 줌 레벨: \(level.zoom)")
                return
            }
        }
        
        // 모든 레벨에서 안 맞으면 가장 큰 레벨 사용
        mapView.zoomLevel = ZoomLevel.extraLarge.zoom
        print("기본 줌 레벨: \(ZoomLevel.extraLarge.zoom)")
    }
    
    // 필요시 카메라 위치 업데이트
    private func updateCameraIfNeeded(_ mapView: NMFMapView) {
        // 특정 조건에 따라 카메라 위치 업데이트
        // 예: 코스 데이터가 변경되었을 때
    }
    
    /// 특정 장소로 카메라 이동하는 함수
    private func moveCameraToPlace(_ place: Place, mapView: NMFMapView, animated: Bool = true) {
        let coordinate = NMGLatLng(lat: place.latitude, lng: place.longitude)
        let cameraUpdate = NMFCameraUpdate(scrollTo: coordinate)
        cameraUpdate.animation = animated ? .easeIn : .none
        mapView.moveCamera(cameraUpdate)
    }
}

// MARK: - Marker Management

extension CourseDetailMapView {
    /// 지도에 마커를 추가하는 함수
    private func addMarkesToMap(_ mapView: NMFMapView) {
        DispatchQueue.global(qos: .default).async {
            var markers: [NMFMarker] = []
  
            for (index, place) in course.places.enumerated() {
                guard let markerType = MarkerType(rawValue: index + 1) else { continue }
                
                let marker = NMFMarker()
                marker.position = NMGLatLng(lat: place.latitude, lng: place.longitude)
                marker.iconImage = markerManager.getMarkerImage(for: markerType, isFocused: place.isFocused)
                marker.width = markerWidth
                marker.height = markerHeight
                marker.anchor = CGPoint(x: 0.5, y: 0.5)
                marker.zIndex = course.places.count - index
                markers.append(marker)
            }

            DispatchQueue.main.async {
                for marker in markers {
                    marker.mapView = mapView
                }
            }
        }
    }
}
