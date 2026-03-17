//
//  CustomModalModifier.swift
//  Solply
//
//  Created by seozero on 3/17/26.
//

import SwiftUI

struct CustomModalModifier: ViewModifier {
    
    // MARK: - Properties
    
    @ObservedObject private var modalManager = ModalManager.shared
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Group {
                    if modalManager.isPresented, let modalType = modalManager.modalType {
                        ZStack(alignment: .center) {
                            Color.coreBlackO40
                                .ignoresSafeArea()
                                .onTapGesture {
                                    modalManager.onDismiss?()
                                }
                            
                            VStack(alignment: .center, spacing: 16.adjustedHeight) {
                                Text(modalType.aiRecommendGuideTitle)
                                    .applySolplyFont(.body_16_m)
                                    .foregroundStyle(.coreBlack)
                                
                                VStack(alignment: .leading, spacing: 8.adjustedHeight) {
                                    ForEach(modalType.aiRecommendGuideContents, id: \.self) { content in
                                        TextWithBulletIcon(content)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.horizontal, 20.adjustedWidth)
                            .padding(.vertical, 20.adjustedHeight)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.coreWhite)
                            )
                            .padding(.horizontal, 20.adjustedWidth)
                        }
                    }
                }
                    .animation(.easeInOut(duration: 0.2), value: modalManager.isPresented)
            )
    }
}

extension View {
    func customModal() -> some View {
        self.modifier(CustomModalModifier())
    }
}
