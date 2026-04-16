//
//  ComplaintCompleteModal.swift
//  Solply
//
//  Created by sun on 4/16/26.
//

import SwiftUI

struct ComplaintCompleteModal: View {
    
    let confirmAction: () -> Void
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.coreBlackO40
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 16.adjustedHeight) {
                
                Image(.successIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 52.adjustedWidth, height: 52.adjustedHeight)
                    .padding(.top, 22.adjustedHeight)
                
                Text("신고가 접수되었어요")
                    .applySolplyFont(.body_16_m)
                    .foregroundStyle(.coreBlack)
                
                Text("커뮤니티를 지켜주셔서 감사합니다!\n검토 후 필요한 조치를 진행할게요.")
                    .applySolplyFont(.body_14_r)
                    .foregroundStyle(.coreBlack)
                    .multilineTextAlignment(.center)
                
                SolplyMainButton(
                    title: "확인",
                    isEnabled: true
                ) {
                    confirmAction()
                }
                .padding(.top, 16.adjustedHeight)
            }
            .padding(.horizontal, 20.adjustedWidth)
            .padding(.vertical, 24.adjustedHeight)
            .frame(width: 260.adjustedWidth)
            .background(.coreWhite)
            .cornerRadius(12)
        }
    }
}

#Preview {
    ComplaintCompleteModal(
        confirmAction: {}
    )
}
