//
//  OnboardingCompleteView.swift
//  Solply
//
//  Created by 선영주 on 7/12/25.
//

import SwiftUI

struct OnboardingCompleteView: View {
    
    var nickname: String
    
    // MARK: - Properties
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("\(nickname)님의 취향을 담았어요.\n솔플리를 시작할게요!")
                .multilineTextAlignment(.center)
                .applySolplyFont(.display_20_sb)
                .padding(.top, 84.adjustedHeight)
            
            Spacer()
            
            Image(.boxGraphic)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 202.adjustedHeight)
        }
        .ignoresSafeArea(edges: .bottom)
        .background(.gray100)
    }
}

#Preview {
    OnboardingCompleteView(nickname: "으갸갸갸갸")
        .environmentObject(AppCoordinator())
}
