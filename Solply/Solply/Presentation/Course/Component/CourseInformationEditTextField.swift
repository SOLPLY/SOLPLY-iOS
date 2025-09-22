//
//  CourseInformationEditTextField.swift
//  Solply
//
//  Created by 김승원 on 9/22/25.
//

import SwiftUI

struct CourseInformationEditTextField: View {
    
    // MARK: - Properties
    
    @Binding private var text: String
    
    // MARK: - Initializer
    
    init(text: Binding<String>) {
        self._text = text
    }
    
    // MARK: - Body
    
    var body: some View {
        TextField("", text: $text)
            .applySolplyFont(.body_16_m)
            .foregroundStyle(.gray800)
            .frame(height: 28.adjustedHeight)
            .padding(.vertical, 12.adjustedHeight)
            .padding(.horizontal, 20.adjustedWidth)
            .background(.coreWhite)
            .cornerRadius(20, corners: .allCorners)
            .addBorder(
                .roundedRectangle(cornerRadius: 20),
                borderColor: .gray300,
                borderWidth: 1
            )
            
    }
}
