//
//  OfflineBanner.swift
//  Solply
//
//  Created by 김승원 on 3/31/26.
//

import SwiftUI

struct OfflineBanner: View {
    
    // MARK: - Properties
    
    private let onRetry: (() -> Void)?
    
    // MARK: - Initializer
    
    init(onRetry: (() -> Void)? = nil) {
        self.onRetry = onRetry
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            text
            
            Spacer()
            
            button
        }
        .padding(.horizontal, 24.adjustedWidth)
        .padding(.bottom, 20.adjustedHeight)
        .padding(.top, 12.adjustedHeight)
        .background(.gray900)
    }
}

// MARK: - Subviews

extension OfflineBanner {
    private var text: some View {
        Text("네트워크를 연결 상태를 확인해주세요")
            .applySolplyFont(.body_14_m)
            .foregroundStyle(.coreWhite)
    }
    
    private var button: some View {
        Button {
            onRetry?()
        } label: {
            HStack(alignment: .center, spacing: 0) {
                Text("재시도")
                    .applySolplyFont(.button_14_m)
                    .foregroundStyle(.gray900)
                
                Image(.retryIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20.adjusted, height: 20.adjusted)
            }
            .frame(width: 85.adjustedWidth, height: 40.adjustedHeight)
            .background(.gray100)
            .capsuleClipped()
            .addBorder(.capsule, borderColor: .gray300, borderWidth: 1)
        }
        .buttonStyle(.plain)
    }
}
