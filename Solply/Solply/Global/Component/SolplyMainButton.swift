//
//  SolplyMainButton.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

import SwiftUI

struct SolplyMainButton: View {
    
    // MARK: - Properties
    
    private let title: String
    private let isEnabled: Bool
    private let isLoading: Bool
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        title: String,
        isEnabled: Bool = true,
        isLoading: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.title   = title
        self.isEnabled = isEnabled
        self.isLoading = isLoading
        self.action  = action
    }
    
    // MARK: - Body
    
    var body: some View {
        if isLoading {
            loadingContent
        } else {
            Button {
                action?()
            } label: {
                content
            }
            .buttonStyle(.plain)
            .allowsHitTesting(isEnabled)
        }
    }
    
    // MARK: - Content View
    
    private var content: some View {
        Text(title)
            .applySolplyFont(.button_16_m)
            .foregroundStyle(isEnabled ? .coreWhite : .gray800)
            .frame(maxWidth: .infinity)
            .frame(height: 64.adjustedHeight)
            .background(
                Capsule()
                    .fill(isEnabled ? .gray900 : .gray300)
            )
            .animation(.easeInOut(duration: 0.2), value: isEnabled)
    }
    
    private var loadingContent: some View {
        ProgressView()
            .tint(.coreWhite)
            .progressViewStyle(.circular)
            .frame(maxWidth: .infinity)
            .frame(height: 64.adjustedHeight)
            .background(
                Capsule()
            )
    }
}


#Preview {
    SolplyMainButton(title: "확인", isEnabled: true, isLoading: false)
    SolplyMainButton(title: "확인", isEnabled: false, isLoading: false)
    SolplyMainButton(title: "확인", isEnabled: true, isLoading: true)
}
