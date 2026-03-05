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
    
    private var workItem: DispatchWorkItem?
    
    // MARK: - Functions
    
    func showToast(
        content: ToastContent,
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
            duration: duration
        )
    }
    
    private func displayToast(
        content: ToastContent,
        duration: TimeInterval = 2.0
    ) {
        self.toastContent = content
        
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
    
    private func hideToast() {
        workItem?.cancel()
        
        withAnimation(.easeInOut(duration: 0.3)) {
            isShowing = false
        }
    }
}

// MARK: - ToastContent

struct ToastContent: Equatable {
    let id: UUID = UUID()
    let toastType: ToastType
    let message: String
    let toastAction: ToastAction?
    let bottomPadding: CGFloat
    
    static func == (lhs: ToastContent, rhs: ToastContent) -> Bool {
        return lhs.id == rhs.id
    }
    
    init(
        toastType: ToastType,
        message: String,
        toastAction: ToastAction? = nil,
        bottomPadding: CGFloat = 28.adjustedHeight
    ) {
        self.toastType = toastType
        self.message = message
        self.toastAction = toastAction
        self.bottomPadding = bottomPadding
    }
}

struct ToastAction {
    let buttonTitle: String
    let action: (() -> Void)
}
