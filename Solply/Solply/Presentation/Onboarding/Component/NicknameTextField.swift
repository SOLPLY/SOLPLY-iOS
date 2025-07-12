//
//  NicknameTextField.swift
//  Solply
//
//  Created by 선영주 on 7/11/25.
//

import SwiftUI

struct NicknameTextField: View {

    @State private var text: String = ""
    private var state: NicknameTextFieldState
    private let maxLength: Int = 8
    private let onChange: ((String) -> Void)?
    
    init(state: NicknameTextFieldState, onChange: ((String) -> Void)? = nil) {
        self.state = state
        self.onChange = onChange
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8.adjustedHeight) {
            HStack(spacing: 8.adjustedHeight) {

                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text("여기에 입력하세요.")
                            .applySolplyFont(.body_16_r)
                            .foregroundColor(.gray500)
                    }
                    
                    TextField("", text: $text)
                        .applySolplyFont(.body_16_r)
                        .foregroundColor(.gray800)
                        .onChange(of: text) { _, newValue in
                            if newValue.count > maxLength {
                                text = String(newValue.prefix(maxLength))
                                onChange?(text)
                            } else {
                                onChange?(text)
                            }
                        }
                }

                if let icon = state.icon {
                    icon
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20.adjustedHeight, height: 20.adjustedHeight)
                        .foregroundColor(state.borderColor)
                }
            }
            .padding(.horizontal, 16.adjustedHeight)
            .frame(height: 56.adjustedHeight)
            .background(.white)
            .cornerRadius(20)
            .addBorder(
                .roundedRectangle(cornerRadius: 20.adjustedHeight),
                borderColor: state.borderColor,
                borderWidth: 1
            )

            HStack {
                Text(state.guidance?.text ?? " ")
                    .applySolplyFont(.caption_12_r)
                    .foregroundColor(state.guidance?.color ?? .clear)

                Spacer()

                Text("\(text.count)/\(maxLength)")
                    .applySolplyFont(.caption_12_r)
                    .foregroundColor(
                        state == .valid ? .gray400 :
                        state == .invalidCharacter || state == .duplicate ? .red500 :
                        .gray400
                    )
            }
            .padding(.horizontal, 4.adjustedHeight)
        }
    }
}
