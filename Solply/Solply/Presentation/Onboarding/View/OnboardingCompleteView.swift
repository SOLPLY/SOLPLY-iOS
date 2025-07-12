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
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("코알라님의 취향을 담았어요.\n솔플리를 시작할게요!")
                .applySolplyFont(.display_20_sb)
                .padding(.top, 24.adjustedHeight)
                .padding(.bottom, 28.adjustedHeight)
        }
    }
}

#Preview {
    OnboardingCompleteView()
        .environmentObject(AppCoordinator())
}
