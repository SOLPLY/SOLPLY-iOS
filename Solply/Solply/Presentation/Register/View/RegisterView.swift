//
//  RegisterView.swift
//  Solply
//
//  Created by 김승원 on 10/10/25.
//

import SwiftUI

struct RegisterView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @StateObject private var store = RegisterStore()
    
    // MARK: - Body
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// MARK: - Subviews

extension RegisterView {
    
}

#Preview {
    RegisterView()
        .environmentObject(AppCoordinator())
}
