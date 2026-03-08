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
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .configureDefaultTextEditor()
                .applySolplyFont(textEditorFont)
                .foregroundStyle(.coreBlack)
                .padding(.horizontal, 10.adjustedWidth)
                .padding(.vertical, 7.adjustedHeight)
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
                    .foregroundStyle(.gray600)
                    .padding(.horizontal, 16.adjustedWidth)
                    .padding(.vertical, 16.adjustedHeight)
            }
        }
        .frame(width: 335.adjustedWidth, height: 156.adjustedHeight)
        .background(.coreWhite)
        .addBorder(
            .roundedRectangle(cornerRadius: 20),
            borderColor: .gray200,
            borderWidth: 1
        )
    }
}

#Preview {
    SolplyTextEditor()
}
