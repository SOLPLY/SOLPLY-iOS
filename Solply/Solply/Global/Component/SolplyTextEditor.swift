//
//  SolplyTextEditor.swift
//  Solply
//
//  Created by 김승원 on 9/12/25.
//

import SwiftUI

struct SolplyTextEditor: View {
    
    // MARK: - Properties
    
    @State private var text: String = ""
    
    private let placeholder: String
    private let isTextLimitEnabled: Bool
    private let onTextChanged: ((String) -> Void)?
    
    private let textEditorFont: SolplyFont = .body_16_r
    private let backgroundColor: Color = .gray100
    private let borderColor: Color = .gray200
    private let placeholderColor: Color = .gray500
    private let textColor: Color = .gray900
    
    // MARK: - Initializer
    
    init(
        placeholder: String = "최대 200자 입력 가능",
        isTextLimitEnabled: Bool = true,
        onTextChanged: ((String) -> Void)? = nil
    ) {
        self.placeholder = placeholder
        self.isTextLimitEnabled = isTextLimitEnabled
        self.onTextChanged = onTextChanged
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 8.adjustedHeight) {
            textEditor
            
            textLimitCount
        }
    }
}

// MARK: - Subviews

extension SolplyTextEditor {
    private var textEditor: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .configureDefaultTextEditor()
                .scrollContentBackground(.hidden)
                .applySolplyFont(textEditorFont)
                .padding(.horizontal, 10.adjustedWidth)
                .padding(.vertical, 7.adjustedHeight)
                .foregroundStyle(textColor)
                .background(.clear)
                .onChange(of: text) { _, newValue in
                    guard isTextLimitEnabled else {
                        onTextChanged?(newValue)
                        return
                    }
                    
                    let limitedText = String(newValue.prefix(200))
                    
                    if limitedText != newValue {
                        text = limitedText
                    }
                    
                    onTextChanged?(limitedText)
                }
            
            if text.isEmpty {
                Text(placeholder)
                    .applySolplyFont(textEditorFont)
                    .foregroundStyle(placeholderColor)
                    .padding(.horizontal, 16.adjustedWidth)
                    .padding(.vertical, 16.adjustedHeight)
            }
        }
        .frame(width: 335.adjustedWidth, height: 156.adjustedHeight)
        .background(backgroundColor)
        .cornerRadius(20, corners: .allCorners)
        .addBorder(
            .roundedRectangle(cornerRadius: 20),
            borderColor: borderColor,
            borderWidth: 1
        )
    }
    
    private var textLimitCount: some View {
        Text("\(text.count)/200")
            .applySolplyFont(.caption_12_m)
            .foregroundStyle(placeholderColor)
            .padding(.trailing, 8.adjustedWidth)
    }
}

#Preview {
    SolplyTextEditor()
}
