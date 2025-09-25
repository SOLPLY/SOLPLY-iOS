//
//  ReportsCompleteView.swift
//  Solply
//
//  Created by 김승원 on 9/25/25.
//

import SwiftUI

struct ReportsCompleteView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 39.adjustedHeight) {
            LottieView(jsonName: "finishOnboarding")
                .frame(width: 230.adjustedWidth, height: 230.adjustedHeight)
                
            Text("소중한 제보 감사합니다!")
                .applySolplyFont(.display_20_sb)
        }
        .background(.coreWhite)
    }
}

#Preview {
    ReportsCompleteView()
}
