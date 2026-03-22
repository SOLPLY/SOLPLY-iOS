//
//  CourseMarkerMap.swift
//  Solply
//
//  Created by 김승원 on 3/22/26.
//

import SwiftUI
import MapKit

struct CourseMarkerMap: View {
    
    // MARK: - Properties
    
    @State private var position: MapCameraPosition
    
    private var places: [CoursePlaceMark]
    
    // MARK: - Initializer
    
    init(places: [CoursePlaceMark]) {
        self.places = places
        _position = State(initialValue: CourseMarkerMap.calculateCameraPosition(for: places))
    }
    
    // MARK: - Body
    
    var body: some View {
        map
            .onChange(of: places.map(\.isFocused)) { _, _ in
                position = CourseMarkerMap.calculateCameraPosition(for: places)
            }
    }
}

// MARK: - Subviews {

extension CourseMarkerMap {
    private var map: some View {
        Map(position: $position) {
            ForEach(Array(places.enumerated()), id: \.offset) { index, place in
                Annotation("", coordinate: place.coordinate, anchor: .center) {
                    Image(place.isFocused ? "marker\(index + 1)-focused-icon" : "marker\(index + 1)-default-icon")
                        .resizable()
                        .frame(width: 36.adjusted, height: 36.adjusted)
                }
            }
            
            MapPolyline(coordinates: places.map(\.coordinate))
                        .stroke(.purple800, lineWidth: 2)
        }
        .animation(.easeInOut(duration: 0.3), value: position)
        .mapControlVisibility(.hidden)
        .mapStyle(.standard(emphasis: .muted))
        .safeAreaPadding(.bottom, 450.adjustedHeight)
    }
}

// MARK: - Helpers

extension CourseMarkerMap {
    private static func calculateCameraPosition(for places: [CoursePlaceMark]) -> MapCameraPosition {
        guard
            let minLatitude = places.map(\.latitude).min(),
            let maxLatitude = places.map(\.latitude).max(),
            let minLongitude = places.map(\.longitude).min(),
            let maxLongitude = places.map(\.longitude).max()
        else {
            return .region(MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            ))
        }
        
        let center = CLLocationCoordinate2D(
            latitude: (minLatitude + maxLatitude) / 2,
            longitude: (minLongitude + maxLongitude) / 2
        )
        
        let padding = 2.0
        let span = MKCoordinateSpan(
            latitudeDelta: (maxLatitude - minLatitude) * padding,
            longitudeDelta: (maxLongitude - minLongitude) * padding
        )
        
        return .region(MKCoordinateRegion(center: center, span: span))
    }
}
