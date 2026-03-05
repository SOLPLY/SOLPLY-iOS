//
//  LengthCheckModifier.swift
//  Solply
//
//  Created by 김승원 on 9/22/25.
//

import SwiftUI

struct LengthCheckModifier: ViewModifier {
    
    @Binding var text: String
    private let minLength: Int?
    private let maxLength: Int?
    private let onValidChanged: ((Bool) -> Void)?
    
    init(
        text: Binding<String>,
        minLength: Int?,
        maxLength: Int?,
        onValidChanged: ((Bool) -> Void)?
    ) {
        self._text = text
        self.minLength = minLength
        self.maxLength = maxLength
        self.onValidChanged = onValidChanged
    }
    
    func body(content: Content) -> some View {
        content
            .onChange(of: text) { _, newText in
                let count = newText.count
                let isValid: Bool
                
                switch (minLength, maxLength) {
                case (nil, nil):
                    isValid = true
                case let (min?, nil):
                    isValid = count >= min
                case let (nil, max?):
                    isValid = count <= max
                case let (min?, max?):
                    isValid = (count >= min && count <= max)
                }
                
                onValidChanged?(isValid)
            }
    }
}

extension View {
    /// 최소/최대 글자 수를 체크하고 상태를 클로저로 전달합니다.
    ///
    /// - Parameters:
    ///   - text: 체크할 텍스트의 바인딩
    ///   - minLength: 텍스트의 최소 길이입니다.
    ///   - maxLength: 텍스트의 최대 길이입니다.
    ///   - onValidChanged: 텍스트 길이가 최소/최대 범위 내에 있는지 여부를 Bool로 전달하는 클로저입니다.
    func lengthCheck(
        text: Binding<String>,
        minLength: Int? = nil,
        maxLength: Int? = nil,
        onValidChanged: ((Bool) -> Void)? = nil
    ) -> some View {
        self.modifier(
            LengthCheckModifier(
                text: text,
                minLength: minLength,
                maxLength: maxLength,
                onValidChanged: onValidChanged
            )
        )
    }
}
