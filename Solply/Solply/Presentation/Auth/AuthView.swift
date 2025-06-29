//
//  AuthView.swift
//  Solply
//
//  Created by 김승원 on 6/29/25.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    var body: some View {
        VStack {
            Text("AuthView")
            
            Button {
                appCoordinator.changeRoot(to: .onboarding)
            } label: {
                Text("chageRoot to OnboardingView")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.cyan)
    }
}

#Preview {
    AuthView()
}
