//
//  TempMapView.swift
//  Solply
//
//  Created by 김승원 on 7/3/25.
//

import SwiftUI

struct TempMapView: View {
    
    @State var coordinate: (Double, Double) = (126.9784147, 37.5666805)
    
    var body: some View {
        ZStack {
            NMapView(coordinate: coordinate)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    TempMapView()
}
