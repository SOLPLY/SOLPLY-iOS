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
    private let placeholder: String
    private let validAction: ((Bool) -> Void)?
    
    // MARK: - Initializer
    
    init(
        text: Binding<String>,
        minLength: Int,
        maxLength: Int,
        placeholder: String,
        validAction: ((Bool) -> Void)? = nil
    ) {
        self._text = text
        self.minLength = minLength
        self.maxLength = maxLength
        self.placeholder = placeholder
        self.validAction = validAction
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 8.adjustedHeight) {
            textField
            
            textCount
        }
    }
}

// MARK: - Subviews

extension CourseInformationEditTextField {
    private var textField: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .applySolplyFont(.body_16_r)
                    .foregroundStyle(.gray500)
            }
            
            TextField("", text: $text)
                .configureDefaultTextField()
                .applySolplyFont(.body_16_m)
                .foregroundStyle(.gray800)
                .onChange(of: text) { _, newValue in
                    if newValue.count > maxLength {
                        text = String(newValue.prefix(maxLength))
                    }
                }
                .lengthCheck(
                    text: $text,
                    minLength: minLength
                ) { isTextLengthValid in
                    validAction?(isTextLengthValid)
                }
        }
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
    
    private var textCount: some View {
        Text("\(text.count)/\(maxLength)")
            .applySolplyFont(.caption_12_m)
            .foregroundStyle(.gray500)
            .frame(height: 18.adjustedHeight)
            .padding(.trailing, 8.adjustedWidth)
    }
}
