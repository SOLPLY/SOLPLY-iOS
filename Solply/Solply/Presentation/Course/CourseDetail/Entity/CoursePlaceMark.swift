//
//  CoursePlaceMark.swift
//  Solply
//
//  Created by 김승원 on 3/22/26.
//

import Foundation
import CoreLocation

struct CoursePlaceMark {
    let latitude: Double
    let longitude: Double
    let isFocused: Bool
}

extension CoursePlaceMark {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }
    
    static func from(_ places: [PlaceDetailInCourse]) -> [CoursePlaceMark] {
        places.map { CoursePlaceMark(latitude: $0.latitude, longitude: $0.longitude, isFocused: $0.isFocused) }
    }
}

extension CoursePlaceMark {
    static let mockData: [CoursePlaceMark] = [
        CoursePlaceMark(latitude: 37.5553018, longitude: 126.8952798, isFocused: false),
        CoursePlaceMark(latitude: 37.5550403, longitude: 126.8995104, isFocused: false),
        CoursePlaceMark(latitude: 37.5544741, longitude: 126.9015912, isFocused: false),
        CoursePlaceMark(latitude: 37.556729,  longitude: 126.9004014, isFocused: false)
    ]
}
