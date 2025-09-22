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
    
    private let minLength: Int
    private let maxLength: Int
    private let validAction: ((Bool) -> Void)?
    
    // MARK: - Initializer
    
    init(
        text: Binding<String>,
        minLength: Int,
        maxLength: Int,
        validAction: ((Bool) -> Void)? = nil
    ) {
        self._text = text
        self.minLength = minLength
        self.maxLength = maxLength
        self.validAction = validAction
    }
    
    // MARK: - Body
    
    var body: some View {
        TextField("", text: $text)
            .configureDefaultTextField()
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
            .lengthCheck(
                text: $text,
                minLength: minLength,
                maxLength: maxLength
            ) { isTextLengthValid in
                validAction?(isTextLengthValid)
            }
    }
}
