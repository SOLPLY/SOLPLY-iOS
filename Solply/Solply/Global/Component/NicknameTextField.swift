//
//  NicknameTextField.swift
//  Solply
//
//  Created by 선영주 on 7/11/25.
//

import SwiftUI

enum CounterVisibility {
    case always
    case whenNotEmpty
}

struct NicknameTextField: View {
    
    // MARK: - Properties

    @State private var text: String
    
    private let placeholder: String
    private let state: NicknameTextFieldState
    private let maxLength: Int = 8
    private let counterVisibility: CounterVisibility
    private let onChange: ((String) -> Void)?
    private let onSubmit: ((String) -> Void)?
    
    private var shouldShowCounter: Bool {
        switch counterVisibility {
        case .always:
            return true
        case .whenNotEmpty:
            return !text.isEmpty
        }
    }
    
    // MARK: - Initializer

    init(
        initialText: String = "",
        placeholder: String = "여기에 입력하세요.",
        state: NicknameTextFieldState,
        counterVisibility: CounterVisibility = .whenNotEmpty,
        onChange: ((String) -> Void)? = nil,
        onSubmit: ((String) -> Void)? = nil
    ) {
        self._text = State(initialValue: initialText)
        self.placeholder = placeholder
        self.state = state
        self.counterVisibility = counterVisibility
        self.onChange = onChange
        self.onSubmit = onSubmit
    }
    
    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 8.adjustedHeight) {
            HStack(spacing: 8.adjustedHeight) {
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeholder)
                            .applySolplyFont(.body_16_m)
                            .foregroundColor(.gray500)
                    }
                    
                    TextField("", text: $text)
                        .configureDefaultTextField()
                        .applySolplyFont(.body_16_m)
                        .foregroundColor(.gray800)
                        .submitLabel(.done)
                        .onChange(of: text) { _, newValue in
                            if newValue.count > maxLength {
                                text = String(newValue.prefix(maxLength))
                                onChange?(text)
                            } else {
                                onChange?(text)
                            }
                        }
                        .submitLabel(.done)
                        .onSubmit {
                            onSubmit?(text)
                        }
                }

                if let icon = state.icon {
                    icon
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20.adjusted, height: 20.adjusted)
                        .foregroundColor(state.borderColor)
                }
            }
            .padding(.horizontal, 16.adjustedHeight)
            .frame(height: 52.adjustedHeight)
            .background(.white)
            .cornerRadius(20)
            .addBorder(
                .roundedRectangle(cornerRadius: 20),
                borderColor: state.borderColor,
                borderWidth: 1
            )

            HStack {
                Text(state.guidance?.text ?? " ")
                    .applySolplyFont(.caption_12_r)
                    .foregroundColor(state.guidance?.color ?? .clear)
                
                Spacer()
                
                if shouldShowCounter {
                    Text("\(text.count)/\(maxLength)")
                        .applySolplyFont(.caption_12_r)
                        .foregroundColor(
                            (state == .invalidCharacter || state == .duplicate) ? .red500 : .gray400
                        )
                        .animation(.easeInOut(duration: 0.15), value: shouldShowCounter)
                }
            }
            .padding(.horizontal, 4.adjustedHeight)
        }
    }
}
