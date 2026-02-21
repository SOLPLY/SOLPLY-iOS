//
//  CustomToastModifier.swift
//  Solply
//
//  Created by 김승원 on 7/12/25.
//

import SwiftUI

struct CustomToastModifier: ViewModifier {
    
    // MARK: - Properties
    
    @ObservedObject var toastManager = ToastManager.shared
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .overlay {
                Group {
                    if toastManager.isShowing {
                        toastContainer
                            .id(toastManager.toastId)
                            .transition(.asymmetric(
                                insertion: .move(edge: .bottom).combined(with: .opacity),
                                removal: .move(edge: .bottom).combined(with: .opacity)
                            ))
                            .highPriorityGesture(
                                DragGesture(minimumDistance: 10, coordinateSpace: .local)
                                    .onChanged { _ in
                                        guard toastManager.isShowing else { return }
                                        toastManager.isShowing = false
                                    }
                            )
                    }
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, toastManager.bottomPadding)
                .animation(.easeInOut(duration: 0.4), value: toastManager.isShowing)
            }
    }
}

// MARK: - Subviews

extension CustomToastModifier {
    private var toastContainer: some View {
        HStack(alignment: .center, spacing: 0) {
            toastContent
        }
        .padding(.horizontal, 16.adjustedWidth)
        .frame(width: 335.adjustedWidth, height: 40.adjusted, alignment: .leading)
        .background(.coreBlack)
        .cornerRadius(12, corners: .allCorners)
    }
    
    @ViewBuilder
    private var toastContent: some View {
        switch toastManager.toastType {
        case .defaultToast:
            message
            
        case .withIconToast:
            icon
            message
            
        case .withActionToast(let buttonTitle, let action):
            message
            Spacer()
            actionButton(buttonTitle: buttonTitle, action: action)
        }
    }
    
    private var icon: some View {
        Image(.warningIcon)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(.coreWhite)
            .frame(width: 24.adjusted, height: 24.adjusted)
    }
    
    private var message: some View {
        Text(toastManager.message)
            .applySolplyFont(.body_14_r)
            .foregroundStyle(.coreWhite)
            .frame(height: 21.adjustedHeight)
    }
    
    private func actionButton(buttonTitle: String, action: (() -> Void)?) -> some View {
        Button {
            action?()
            toastManager.isShowing = false
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
                    .frame(width: 24.adjusted, height: 24.adjusted)
            }
        }
        .buttonStyle(.plain)
        .padding(.trailing, -8.adjustedWidth)
    }
}

extension View {
    func customToast() -> some View {
        self.modifier(CustomToastModifier())
    }
}
