//
//  PolicyCell.swift
//  Solply
//
//  Created by sun on 11/3/25.
//

import SwiftUI

struct PolicyCell: View {
    
    // MARK: - Properties
    
    private let title: String
    private let isRequired: Bool
    private let isChecked: Bool
    private let showsChevron: Bool
    private let onToggle: (() -> Void)?
    private let onShowPolicy: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        title: String,
        isRequired: Bool,
        isChecked: Bool,
        showsChevron: Bool = false,
        onToggle: (() -> Void)? = nil,
        onShowPolicy: (() -> Void)? = nil
    ) {
        self.title = title
        self.isRequired = isRequired
        self.isChecked = isChecked
        self.showsChevron = showsChevron
        self.onToggle = onToggle
        self.onShowPolicy = onShowPolicy
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Button {
                onToggle?()
            } label: {
                HStack(alignment: .center, spacing: 4.adjustedWidth) {
                    Image(isChecked ? .selectCheckIcon : .defaultCheckIcon)
                        .resizable()
                        .frame(width: 24.adjusted, height: 24.adjusted)
                    
                    Text("\(prefix)\(title)")
                        .applySolplyFont(.body_14_m)
                        .foregroundColor(.gray900)
                }
            }
            .buttonStyle(.plain)
            
            Spacer()
            
            if showsChevron {
                Button {
                    onShowPolicy?()
                } label: {
                    Image(.arrowRightIconLightGray)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12.adjusted, height: 12.adjusted)
                }
            }
        }
    }
    
    private var prefix: String {
        isRequired ? "(필수) " : "(선택) "
    }
}
