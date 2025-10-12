//
//  RegisterSearchBar.swift
//  Solply
//
//  Created by 김승원 on 10/11/25.
//

import SwiftUI

struct RegisterSearchBar: View {
    
    // MARK: - Properties
    
    @State private var text: String = ""
    
    private let onChange: ((String) -> Void)?
    private let onSubmit: ((String) -> Void)?
    private let registerAction: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        onChange: ((String) -> Void)? = nil,
        onSubmit: ((String) -> Void)? = nil,
        registerAction: (() -> Void)? = nil
    ) {
        self.onChange = onChange
        self.onSubmit = onSubmit
        self.registerAction = registerAction
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .leading) {
            container
            
            placeholder
            
            HStack(alignment: .center, spacing: 10.adjustedWidth) {
                textField
                
                registerButton
            }
            .frame(height: 28.adjustedHeight)
            .padding(.horizontal, 20.adjustedWidth)
        }
    }
}

// MARK: - Subviews

extension RegisterSearchBar {
    private var container: some View {
        Rectangle()
            .foregroundStyle(.coreWhite)
            .frame(maxWidth: .infinity)
            .frame(height: 52.adjustedHeight)
            .addBorder(.roundedRectangle(cornerRadius: 20), borderColor: .gray300, borderWidth: 1)
    }
    
    private var placeholder: some View {
        Group {
            if text.isEmpty {
                Text("장소 이름을 입력하세요")
                    .applySolplyFont(.body_16_r)
                    .foregroundColor(.gray500)
                    .padding(.horizontal, 20.adjustedWidth)
            }
        }
    }
    
    private var textField: some View {
        TextField("", text: $text)
            .configureDefaultTextField()
            .applySolplyFont(.body_16_r)
            .foregroundColor(.coreBlack)
            .submitLabel(.done)
            .onChange(of: text) { _, newValue in
                onChange?(text)
            }
            .submitLabel(.search)
            .onSubmit {
                onSubmit?(text)
            }
    }
    
    private var registerButton: some View {
        Group {
            if !text.isEmpty {
                Button {
                    registerAction?()
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

#Preview {
    RegisterSearchBar()
}
