//
//  NicknameView.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

import SwiftUI

struct NicknameView: View {
    @EnvironmentObject var appCoordinator: AppCoordinator
    @ObservedObject var store: OnboardingStore

    var body: some View {
        VStack {
            Text("")
                .padding()

            Spacer()

            CTAMainButton(title: "다음") {
                appCoordinator.changeRoot(to: .tabBar)
            }
            .padding(.bottom, 40)
        }
    }
}
