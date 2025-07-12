//
//  ToastModifier.swift
//  Solply
//
//  Created by 김승원 on 7/12/25.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    
    // MARK: - Properties
    
    @ObservedObject var toastManager: ToastManager
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .overlay(
                VStack {
                    if toastManager.isShowing {
                        ToastView(
                            toastType: toastManager.toastType,
                            message: toastManager.message,
                            buttonTitle: toastManager.buttonTitle,
                            action: toastManager.action
                        )
                        .transition(.asymmetric(
                            insertion: .move(edge: .bottom).combined(with: .opacity),
                            removal: .move(edge: .bottom).combined(with: .opacity))
                        )
                    }
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 28.adjustedHeight)
                .animation(.easeInOut(duration: 0.4), value: toastManager.isShowing)
            )
    }
}


extension View {
    func toast(toastManager: ToastManager) -> some View {
        self.modifier(ToastModifier(toastManager: toastManager))
    }
}
