//
//  CustomNavigationBarModifier.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import SwiftUI

struct CustomNavigationBarModifier<C, L, R>: ViewModifier where C: View, L: View, R: View {
    let centerView: (() -> C)?
    let leftView: (() -> L)?
    let rightView: (() -> R)?
    let backgroundColor: Color
    
    init(
        centerView: (() -> C)? = nil,
        leftView: (() -> L)? = nil,
        rightView: (() -> R)? = nil,
        backgroundColor: Color = .clear
    ) {
        self.centerView = centerView
        self.leftView = leftView
        self.rightView = rightView
        self.backgroundColor = backgroundColor
    }
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            ZStack(alignment: .center) {
                HStack(spacing: 0) {
                    self.leftView?()
                    
                    Spacer()
                    
                    self.rightView?()
                }
                
                self.centerView?()
                
            }
            
            // TODO: 네비게이션 패딩값 나오면 수정 필요
            .padding(.horizontal, 0)
            .padding(.vertical, 0)
            .background(backgroundColor)
            
            content
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}
