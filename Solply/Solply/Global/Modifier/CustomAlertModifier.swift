//
//  CustomAlertModifier.swift
//  Solply
//
//  Created by LEESOOYONG on 7/12/25.
//

import SwiftUI

struct CustomAlertModifier: ViewModifier {
    
    // MARK: - Properties
    
    @ObservedObject private var alertManager = AlertManager.shared
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Group {
                    if alertManager.isPresented, let alertType = alertManager.alertType {
                        ZStack(alignment: .center) {
                            Color.coreBlackO40
                                .ignoresSafeArea()
                            
                            VStack(spacing: 8.adjustedHeight) {
                                Text(alertType.title)
                                    .applySolplyFont(.body_14_r)
                                    .frame(width: 236.adjustedWidth, height: 65.adjustedHeight)
                                    .multilineTextAlignment(.center)
                                
                                HStack(alignment: .center, spacing: 0.adjustedWidth) {
                                    Button {
                                        alertManager.onCancel?()
                                    } label: {
                                        Text(alertType.cancelText)
                                            .applySolplyFont(.button_14_r)
                                            .frame(width: 114.adjustedWidth, height: 48.adjustedHeight)
                                            .foregroundStyle(.gray900)
                                    }
                                    .buttonStyle(.plain)
                                    
                                    Button {
                                        alertManager.onConfirm?()
                                    } label: {
                                        Text(alertType.confirmText)
                                            .applySolplyFont(.button_14_r)
                                            .frame(width: 122.adjustedWidth, height: 48.adjustedHeight)
                                            .foregroundStyle(.coreWhite)
                                            .background(.gray900)
                                            .capsuleClipped()
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .frame(width: 260.adjustedWidth, height: 145.adjustedHeight)
                            .background(.coreWhite)
                            .cornerRadius(12)
                        }
                        .transition(.opacity)
                    }
                }
                    .animation(.easeInOut(duration: 0.2), value: alertManager.isPresented)
            )
    }
}

extension View {
    func customAlert() -> some View {
        self.modifier(CustomAlertModifier())
    }
}
