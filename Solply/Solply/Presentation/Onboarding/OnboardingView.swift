//
//  OnboardingView.swift
//  Solply
//
//  Created by 김승원 on 6/29/25.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    var body: some View {
        VStack {
            Text("OnboardingView")
            
            Button {
                appCoordinator.changeRoot(to: .tabBar)
            } label: {
                Text("changeRoot to TabBarView")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.orange)
    }
}

#Preview {
    OnboardingView()
}
