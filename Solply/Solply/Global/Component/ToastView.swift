//
//  ToastView.swift
//  Solply
//
//  Created by 김승원 on 7/12/25.
//

import SwiftUI

struct ToastView: View {
    
    // MARK: - Properties
    
    private let toastType: ToastType
    private let message: String
    private let buttonTitle: String?
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(toastType: ToastType, message: String, buttonTitle: String? = nil, action: (() -> Void)? = nil) {
        self.toastType = toastType
        self.message = message
        self.buttonTitle = buttonTitle
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 4.adjustedWidth) {
                if toastType == .withIconToast {
                    Image(.warningIcon)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.coreWhite)
                        .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                }
                
                Text(message)
                    .applySolplyFont(.body_14_r)
                    .foregroundStyle(.coreWhite)
                    .frame(height: 21.adjustedHeight)
                
                if let buttonTitle, toastType == .withActionToast {
                    Spacer()
                    
                    Button {
                        action?()
                    } label: {
                        HStack(alignment: .center, spacing: 0) {
                            Text(buttonTitle)
                                .applySolplyFont(.body_14_m)
                                .foregroundStyle(.purple300)
                            
                            Image(.arrowRightIcon)
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(.purple300)
                                .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                        }
                    }
                    .buttonStyle(.plain)
                    .padding(.trailing, -8.adjustedWidth)
                }
            }
            .padding(.horizontal, 16.adjustedWidth)
            .frame(width: 335.adjustedWidth, height: 40.adjustedHeight, alignment: .leading)
            .background(.coreBlack)
            .cornerRadius(12, corners: .allCorners)
        }
    }
}
