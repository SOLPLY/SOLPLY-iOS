//
//  SocialLoginButton.swift
//  Solply
//
//  Created by 김승원 on 11/8/25.
//

import SwiftUI

struct SocialLoginButton: View {
    
    // MARK: - Properties
    
    private let socialLoginType: SocialLoginType
    private let action: (() -> Void)?
    
    // MARK: - Initializer
    
    init(_ socialLoginType: SocialLoginType, action: (() -> Void)? = nil) {
        self.socialLoginType = socialLoginType
        self.action = action
    }
    
    // MARK: - Body
    
    var body: some View {
        Button {
            action?()
        } label: {
            HStack(alignment: .center, spacing: 12.adjustedWidth) {
                Image(socialLoginType.buttonIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28.adjusted, height: 28.adjusted)
                
                Text(socialLoginType.buttonTitle)
                    .applySolplyFont(.button_16_m)
                    .foregroundColor(socialLoginType.buttonTitleColor)
            }
            .frame(height: 52.adjusted)
            .padding(.leading, 16.adjustedWidth)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(socialLoginType.buttonBackgroundColor)
            .cornerRadius(12)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SocialLoginButton(.kakao)
    SocialLoginButton(.apple)
}
