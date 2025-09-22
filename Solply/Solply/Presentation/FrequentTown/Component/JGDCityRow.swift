//
//  JGDSelectRow.swift
//  Solply
//
//  Created by seozero on 9/20/25.
//

import SwiftUI

struct JGDCityRow: View {
    
    // MARK: - Properties
    
    @Binding private var selectedCity: String?
    @Binding private var selectedTown: String?
    private let city: String

    // MARK: - Initializer
    
    init(
        selectedCity: Binding<String?>,
        selectedTown: Binding<String?>,
        city: String
    ) {
        self._selectedCity = selectedCity
        self._selectedTown = selectedTown
        self.city = city
    }
    
    // MARK: - Body
    
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
            .contentShape(Rectangle())
        }
        .background(selectedCity == city ? .coreWhite : .gray100)
        .buttonStyle(.plain)
    }
}
