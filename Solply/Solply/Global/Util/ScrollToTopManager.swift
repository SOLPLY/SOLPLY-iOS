//
//  ScrollToTopManager.swift
//  Solply
//
//  Created by 김승원 on 2/20/26.
//

import Foundation

class ScrollToTopManager: ObservableObject {
    
    // MARK: - Properties
    
    @Published var target: TabBarState? = nil
    
    // MARK: - Functions
    
    func trigger(_ tab: TabBarState) {
        target = tab
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.target = nil
        }
    }
}
