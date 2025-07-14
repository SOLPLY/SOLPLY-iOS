//
//  ToastView.swift
//  Solply
//
//  Created by 김승원 on 7/12/25.
//

import SwiftUI

struct ToastView: View {
    
    // MARK: - Properties
    
    private let toastContent: ToastContent
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(toastContent: ToastContent, action: (() -> Void)? = nil) {
        self.toastContent = toastContent
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 4.adjustedWidth) {
                if toastContent.toastType == .withIconToast {
                    Image(.warningIcon)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.coreWhite)
                        .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                }
                
                Text(toastContent.message)
                    .applySolplyFont(.body_14_r)
                    .foregroundStyle(.coreWhite)
                    .frame(height: 21.adjustedHeight)
                
                if let buttonTitle = toastContent.buttonTitle, toastContent.toastType == .withActionToast {
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
