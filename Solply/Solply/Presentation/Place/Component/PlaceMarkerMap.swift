//
//  PlaceMarkerMap.swift
//  Solply
//
//  Created by 김승원 on 3/22/26.
//

import SwiftUI
import MapKit

struct PlaceMarkerMap: View {
    
    // MARK: - Properties
    
    private let latitude: Double?
    private let longitude: Double?
    
    // MARK: - Initializer
    
    init(latitude: Double?, longitude: Double?) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    // MARK: - Body
    
    var body: some View {
        if let latitude, let longitude {
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
            )
            
            Map(initialPosition: .region(region), interactionModes: []) {
                Annotation("", coordinate: coordinate, anchor: .bottom) {
                    Image(.mapMarkPlace)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 36.adjusted, height: 36.adjusted)
                }
            }
            .mapControlVisibility(.hidden)
            .mapStyle(.standard)
        }
    }
}
