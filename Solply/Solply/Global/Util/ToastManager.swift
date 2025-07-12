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
    @Published var toastType: ToastType = .defaultToast
    @Published var message: String = ""
    @Published var buttonTitle: String? = nil
    @Published var action: (() -> Void)? = nil
    
    private var workItem: DispatchWorkItem?

    // MARK: - Functions
    
    func showToast(
        type: ToastType,
        message: String,
        buttonTitle: String? = nil,
        action: (() -> Void)? = nil,
        duration: TimeInterval = 2.0
    ) {
        workItem?.cancel()
        
        if isShowing {
            withAnimation(.easeInOut(duration: 0.2)) {
                isShowing = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.displayToast(
                    type: type,
                    message: message,
                    buttonTitle: buttonTitle,
                    action: action,
                    duration: duration
                )
            }
        } else {
            displayToast(
                type: type,
                message: message,
                buttonTitle: buttonTitle,
                action: action,
                duration: duration
            )
        }
    }
    
    private func displayToast(
        type: ToastType,
        message: String,
        buttonTitle: String? = nil,
        action: (() -> Void)? = nil,
        duration: TimeInterval = 2.0
    ) {
        self.toastType = type
        self.message = message
        self.buttonTitle = buttonTitle
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

