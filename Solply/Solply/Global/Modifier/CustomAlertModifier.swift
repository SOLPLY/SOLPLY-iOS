//
//  CustomAlertModifier.swift
//  Solply
//
//  Created by LEESOOYONG on 7/12/25.
//

import SwiftUI

struct CustomAlertModifier: ViewModifier {
    
    // MARK: - Properties
    
    private let alertType: AlertType
    private let title: String
    private let isPresented: Bool
    private let onCancel: (() -> Void)?
    private let onConfirm: (() -> Void)?
    
    // MARK: - Initializers
    
    init(
        alertType: AlertType,
        title: String,
        isPresented: Bool,
        onCancel: (() -> Void)?,
        onConfirm: (() -> Void)?
    ) {
        self.alertType = alertType
        self.title = title
        self.isPresented = isPresented
        self.onCancel = onCancel
        self.onConfirm = onConfirm
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Group {
                    if isPresented {
                        ZStack(alignment: .center) {
                            Color.coreBlackO40
                                .ignoresSafeArea()
                            
                            VStack(spacing: 8.adjustedHeight) {
                                Text(title)
                                    .applySolplyFont(.body_14_r)
                                    .frame(width: 236.adjustedWidth, height: 65.adjustedHeight)
                                    .multilineTextAlignment(.center)
                                
                                HStack(spacing: 12.adjustedWidth) {
                                    Button {
                                        onCancel?()
                                    } label: {
                                        Text("취소")
                                            .applySolplyFont(.button_14_r)
                                            .frame(width: 114.adjustedWidth, height: 48.adjustedHeight)
                                            .foregroundStyle(.gray900)
                                    }
                                    
                                    Button {
                                        onConfirm?()
                                    } label: {
                                        Text(alertType.mainText)
                                            .applySolplyFont(.button_14_r)
                                            .frame(width: 122.adjustedWidth, height: 48.adjustedHeight)
                                            .foregroundStyle(.coreWhite)
                                            .background(.gray900)
                                            .capsuleClipped()
                                    }
                                }
                            }
                            .frame(width: 260.adjustedWidth, height: 145.adjustedHeight)
                            .padding(.vertical, 12.adjustedHeight)
                            .padding(.horizontal, 12.adjustedWidth)
                            .background(.coreWhite)
                            .cornerRadius(12)
                        }
                    }
                }
            )
    }
}

extension CustomAlertModifier {
    enum AlertType {
        case delete
        case leave

        var mainText: String {
            switch self {
            case .delete: return "삭제"
            case .leave: return "나가기"
            }
        }
    }
}

extension View {
    func customAlert(
        alertType: CustomAlertModifier.AlertType,
        title: String,
        isPresented: Bool,
        onCancel: (() -> Void)?,
        onConfirm: (() -> Void)?
    ) -> some View {
        self.modifier(
            CustomAlertModifier(
                alertType: alertType,
                title: title,
                isPresented: isPresented,
                onCancel: onCancel,
                onConfirm: onConfirm
            )
        )
    }
}
