//
//  SolplyTextField.swift
//  Solply
//
//  Created by 김승원 on 3/20/26.
//

import SwiftUI

struct SolplyTextField: View {
    
    // MARK: - Properties
    
    enum Style {
        case textField
        case searchBar
        case register(action: ((String) -> Void)?)
    }
    
    @State private var text: String = ""
    
    private let style: Style
    private let placeholder: String
    private let onSubmit: ((String) -> Void)?
    
    // MARK: - Initializer
    
    init(
        _ style: Style,
        placeholder: String,
        onSubmit: ((String) -> Void)?
    ) {
        self.style = style
        self.placeholder = placeholder
        self.onSubmit = onSubmit
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 8.adjustedWidth) {
            textField
            
            switch style {
            case .textField:
                EmptyView()
            case .searchBar:
                searchButton
            case .register(let action):
                registerButton(action)
            }
        }
        .padding(.horizontal, 20.adjustedWidth)
        .frame(width: 343.adjustedWidth, height: 52.adjustedHeight)
        .foregroundStyle(.coreWhite)
        .addBorder(
            .roundedRectangle(cornerRadius: 20),
            borderColor: .gray300,
            borderWidth: 1
        )
    }
}

// MARK: - Subviews

extension SolplyTextField {
    private var textField: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .applySolplyFont(.body_16_r)
                    .foregroundColor(.gray500)
            }
            
            TextField("", text: $text)
                .configureDefaultTextField()
                .applySolplyFont(.body_16_r)
                .foregroundStyle(.coreBlack)
                .onSubmit {
                    onSubmit?(text)
                }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 24.adjustedHeight)
    }
    
    private var searchButton: some View {
        Button {
            onSubmit?(text)
        } label: {
            Image(.searchIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24.adjusted, height: 24.adjusted)
        }
        .buttonStyle(.plain)
    }
    
    private func registerButton(_ action: ((String) -> Void)?) -> some View {
        Group {
            if !text.isEmpty {
                Button {
                    action?(text)
                } label: {
                    Text("직접 등록")
                        .applySolplyFont(.body_14_r)
                        .foregroundStyle(.purple600)
                        .underline()
                }
                .buttonStyle(.plain)
            }
        }
    }
}
