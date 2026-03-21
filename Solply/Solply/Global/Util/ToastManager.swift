//
//  ToastManager.swift
//  Solply
//
//  Created by 김승원 on 7/12/25.
//

import SwiftUI

class ToastManager: ObservableObject {
    
    // MARK: - Singleton
    
    static let shared: ToastManager = ToastManager()
    private init() {}
    
    // MARK: - Properties
    
    @Published var isShowing: Bool = false
    
    private(set) var toastId: UUID = UUID()
    private(set) var toastType: ToastType = .defaultToast
    private(set) var message: String = ""
    private(set) var bottomPadding: CGFloat = 28.adjustedHeight
    
    private var workItem: DispatchWorkItem?
    private let duration: TimeInterval = 2.0
    
    // MARK: - Functions
    
    func showToast(
        _ toastType: ToastType,
        message: String,
        bottomPadding: CGFloat = 28.adjustedHeight
    ) {
        workItem?.cancel()
        
        if isShowing {
            withAnimation(.easeInOut(duration: 0.2)) {
                isShowing = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.displayToast(
                    toastType: toastType,
                    message: message,
                    bottomPadding: bottomPadding
                )
            }
        } else {
            displayToast(
                toastType: toastType,
                message: message,
                bottomPadding: bottomPadding
            )
        }
    }
    
    private func displayToast(
        toastType: ToastType,
        message: String,
        bottomPadding: CGFloat
    ) {
        self.toastType = toastType
        self.message = message
        self.bottomPadding = bottomPadding
        self.toastId = UUID()
        
        withAnimation(.easeInOut(duration: 0.3)) {
            self.isShowing = true
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
