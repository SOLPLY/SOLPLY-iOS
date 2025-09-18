//
//  ToastManager.swift
//  Solply
//
//  Created by 김승원 on 7/12/25.
//

import SwiftUI

class ToastManager: ObservableObject {
    
    // MARK: - Properties
    
    @Published var isShowing: Bool = false
    @Published var toastContent: ToastContent?
    @Published var action: (() -> Void)? = nil
    
    private var workItem: DispatchWorkItem?
    
    // MARK: - Functions
    
    func showToast(
        content: ToastContent,
        action: (() -> Void)? = nil,
        duration: TimeInterval = 2.0
    ) {
        workItem?.cancel()
        
        if isShowing {
            withAnimation(.easeInOut(duration: 0.2)) {
                isShowing = false
            }
        }
        
        self.displayToast(
            content: content,
            action: action,
            duration: duration
        )
    }
    
    private func displayToast(
        content: ToastContent,
        action: (() -> Void)? = nil,
        duration: TimeInterval = 2.0
    ) {
        self.toastContent = content
        self.action = action
        
        withAnimation(.easeInOut(duration: 0.3)) {
            isShowing = true
        }
        
        workItem = DispatchWorkItem {
            withAnimation(.easeInOut(duration: 0.3)) {
                self.isShowing = false
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: workItem!)
    }
    
    func hideToast() {
        workItem?.cancel()
        
        withAnimation(.easeInOut(duration: 0.3)) {
            isShowing = false
        }
    }
}

// MARK: - ToastContent

struct ToastContent: Equatable {
    let toastType: ToastType
    let message: String
    let buttonTitle: String?
    let bottomPadding: CGFloat
    let id: UUID = UUID()
    
    init(
        toastType: ToastType,
        message: String,
        buttonTitle: String?,
        bottomPadding: CGFloat = 28.adjustedHeight
    ) {
        self.toastType = toastType
        self.message = message
        self.buttonTitle = buttonTitle
        self.bottomPadding = bottomPadding
    }
}
