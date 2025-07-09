//
//  NicknameView.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

import SwiftUI

struct NicknameView: View {
    @ObservedObject var store: OnboardingStore

    var body: some View {
        VStack {
            Spacer()
            Text("타운 선택 화면")
                .padding()

            Spacer()

            CTAMainButton(title: "다음") {
                store.dispatch(.next)
            }
            .padding(.bottom, 40)
        }
    }
}
