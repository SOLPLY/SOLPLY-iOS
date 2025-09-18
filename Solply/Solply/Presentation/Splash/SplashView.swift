//
//  SplashView.swift
//  Solply
//
//  Created by 선영주 on 7/14/25.
//

import SwiftUI

struct SplashView: View {
    
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    private let userService = UserService()
    
    var body: some View {
        ZStack {
            Color.green300
                .ignoresSafeArea()

            LottieView(jsonName: "Splash")
                .frame(width: 122.adjustedHeight, height: 122.adjustedHeight)
        }
        .task {
            await decideInitialRoute()
        }
    }
    @MainActor
    private func decideInitialRoute() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)

        // 1) 저장된 토큰 자체가 없으면 바로 Auth
        guard TokenManager.shared.isSessionAvailable else {
            appCoordinator.changeRoot(to: .auth)
            return
        }

        // 2) 토큰은 있으니 가볍게 유효성 확인 (예: /api/users)
        do {
            _ = try await userService.fetchUserInformation()
            // 정상 응답 → 탭바로 진입
            appCoordinator.changeRoot(to: .tabBar)

        } catch let error as NetworkError {
            switch error {
            case .unauthorized:
                // 진짜 인증 실패(401/403)일 때만 세션 정리 후 Auth로
                TokenManager.shared.clearTokens()
                appCoordinator.changeRoot(to: .auth)

            default:
                // (초기 데이터 실패는 각 탭 화면에서 자체 에러 UI/재시도 처리)
                appCoordinator.changeRoot(to: .tabBar)
            }

        } catch {
            // 알 수 없는 오류도 루트 전환은 탭바로 고정
            appCoordinator.changeRoot(to: .tabBar)
        }
    }
}

#Preview {
    SplashView()
}
