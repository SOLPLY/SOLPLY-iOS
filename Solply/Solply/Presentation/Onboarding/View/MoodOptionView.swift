//
//  MoodOptionView.swift
//  Solply
//
//  Created by 선영주 on 7/9/25.
//

import SwiftUI

struct MoodOptionView: View {
    @ObservedObject var store: OnboardingStore

    var body: some View {
        VStack {
            Spacer()
            Text("무드 선택 화면")
                .padding()

            Spacer()
            
            HStack(spacing: 12.adjustedWidth) {
                
                CTASubButton(title: "건너뛰기", type: .clear) {
                    store.dispatch(.skip)
                }
                    .frame(width: 90.adjustedWidth)
                
                CTAMainButton(title: "다음"){
                    store.dispatch(.next)
                }
                    .frame(maxWidth: .infinity)
            }
            .padding(.bottom, 40)
        }
    }
}
