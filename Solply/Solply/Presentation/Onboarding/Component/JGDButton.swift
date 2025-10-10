//
//  JGDButton.swift
//  Solply
//
//  Created by sun on 10/6/25.
//

import SwiftUI

struct JGDButton: View {

    // MARK: - Properties
    
    private let title: String?
    private let isSelected: Bool
    private let action: (() -> Void)?

    // MARK: - Initializer
    
    init(
        title: String?,
        isSelected: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.isSelected = isSelected
        self.action = action
    }

    // MARK: - Body
    
    var body: some View {
        Button { action?() } label: {
            HStack(alignment: .center, spacing: 10.adjustedWidth) {
                if let title {
                    Text(title)
                        .applySolplyFont(.button_16_m)
                        .foregroundColor(.gray900)
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    Image(.plusIcon)
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                        .foregroundColor(.gray400)
                }
            }
            .frame(width: 343.adjustedWidth, height: 52.adjustedHeight, alignment: .center)
            .background(backgroundColor)
            .cornerRadius(20, corners: .allCorners)
            .overlay(borderOverlay)
            .contentShape(RoundedRectangle(cornerRadius: 20.adjustedHeight))
        }
        .buttonStyle(.plain)
    }

    // MARK: - Private Views
    
    private var backgroundColor: Color {
        if isSelected {
            return .red100
        } else {
            return .gray200
        }
    }

    private var borderOverlay: some View {
        Group {
            if isSelected {
                RoundedRectangle(cornerRadius: 20.adjustedHeight)
                    .stroke(.red300, lineWidth: 1)
            } else {
                RoundedRectangle(cornerRadius: 20.adjustedHeight)
                    .stroke(.clear)
            }
        }
    }
}
