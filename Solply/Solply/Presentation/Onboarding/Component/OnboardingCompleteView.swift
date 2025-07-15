//
//  OnboardingCompleteView.swift
//  Solply
//
//  Created by 선영주 on 7/12/25.
//

import SwiftUI

struct OnboardingCompleteView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @ObservedObject private var store: OnboardingStore
    
    // MARK: - Initializer
    
    init(store: OnboardingStore) {
        self.store = store
        print(store.state.nickname)
    }

    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("\(store.state.nickname)님의 취향을 담았어요.\n솔플리를 시작할게요!")
                .multilineTextAlignment(.center)
                .applySolplyFont(.display_20_sb)
                .padding(.top, 84.adjustedHeight)
            
            LottieView(jsonName: "Splash")
                .frame(width: 230.adjustedHeight, height: 230.adjustedHeight)
            
            Image(.boxGraphic)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 202.adjustedHeight)
        }
        .ignoresSafeArea(edges: .bottom)
        .background(.gray100)
        .onAppear {
            store.dispatch(.onboardingCompleteOnAppear)
        }
        .onChange(of: store.state.isLottieFinished) { _, newValue in
            if newValue {
                appCoordinator.changeRoot(to: .tabBar)
            }
        }
    }
}
