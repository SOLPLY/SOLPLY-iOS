//
//  ModalManager.swift
//  Solply
//
//  Created by seozero on 3/17/26.
//

import SwiftUI

class ModalManager: ObservableObject {
    
    // MARK: - Singleton
    
    static let shared: ModalManager = ModalManager()
    private init() {}
    
    // MARK: - Properties
    
    @Published var isPresented: Bool = false
    @Published var modalType: ModalType?
    @Published var onDismiss: (() -> Void)? = nil
    
    // MARK: - Functions
    
    func showModal(
        modalType: ModalType
    ) {
        self.modalType = modalType
        
        self.isPresented = true
    }
}
