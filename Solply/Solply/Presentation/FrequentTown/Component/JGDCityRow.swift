//
//  JGDSelectRow.swift
//  Solply
//
//  Created by seozero on 9/20/25.
//

import SwiftUI

struct JGDCityRow: View {
    @Binding var selectedCity: String?
    @Binding var selectedTown: String?
    let city: String

    var body: some View {
        Button {
            self.selectedCity = city
            self.selectedTown = nil
        } label: {
            ZStack(alignment: .bottom) {
                Text(city)
                    .applySolplyFont(.body_16_m)
                    .foregroundStyle(selectedCity == city ? .coreBlack : .gray600)
                    .frame(height: 46.adjustedHeight)
                
                Rectangle()
                    .foregroundStyle(.gray200)
                    .frame(height: 1.adjustedHeight)
            }
        }
        .background(selectedCity == city ? .coreWhite : .gray100)
        .buttonStyle(.plain)
    }
}
