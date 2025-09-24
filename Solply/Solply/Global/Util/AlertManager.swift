//
//  AlertManager.swift
//  Solply
//
//  Created by 김승원 on 9/24/25.
//

import SwiftUI

class AlertManager: ObservableObject {
    
    // MARK: - Properties
    
    @Published var isPresented: Bool = false
    @Published var alertType: AlertType = .deleteCourse
    @Published var onCancel: (() -> Void)? = nil
    @Published var onConfirm: (() -> Void)? = nil
    
    // MARK: - Functions
    
    func showAlert(
        alertType: AlertType,
        onCancel: (() -> Void)? = nil,
        onConfirm: (() -> Void)? = nil
    ) {
        self.alertType = alertType
        self.onCancel = {
            onCancel?()
            self.dismiss()
        }
        
        self.onConfirm = {
            onConfirm?()
            self.dismiss()
        }
        
        self.isPresented = true
    }
    
    private func dismiss() {
        self.isPresented = false
        self.onCancel = nil
        self.onConfirm = nil
    }
}
