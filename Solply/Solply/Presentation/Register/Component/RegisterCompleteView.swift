//
//  RegisterCompleteView.swift
//  Solply
//
//  Created by 김승원 on 10/11/25.
//

import SwiftUI

struct RegisterCompleteView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    var body: some View {
        VStack(alignment: .center, spacing: 39.adjustedHeight) {
            LottieView(jsonName: "finishOnboarding")
                .frame(width: 230.adjustedWidth, height: 230.adjustedHeight)
            
            Text("등록 요청 완료!\n장소가 등록되면 알려드릴게요\n솔플리에서 곧 만나요")
                .applySolplyFont(.display_20_sb)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 130.adjustedHeight)
        .background(.coreWhite)
        .navigationBarHidden(true)
        .disableSwipeBack()
        .onAppear {
            Task {
                await waitForLottie()
            }
        }
    }
}

extension RegisterCompleteView {
    func waitForLottie() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        appCoordinator.goToRoot()
    }
}

#Preview {
    RegisterCompleteView()
        .environmentObject(AppCoordinator())
}
