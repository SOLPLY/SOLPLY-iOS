//
//  SplashView.swift
//  Solply
//
//  Created by 선영주 on 7/14/25.
//

import SwiftUI

struct SplashView: View {
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    var body: some View {
        ZStack {
            Color.green300
                .ignoresSafeArea()

            LottieView(jsonName: "Splash")
                .frame(width: 122.adjustedHeight, height: 122.adjustedHeight)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                appCoordinator.changeRoot(to: .auth)
            }
        }
    }
}

#Preview {
    SplashView()
}
