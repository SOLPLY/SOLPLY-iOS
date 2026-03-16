//
//  EmptyArchiveButton.swift
//  Solply
//
//  Created by 김승원 on 3/14/26.
//

import SwiftUI

struct EmptyArchiveButton: View {
    
    // MARK: - Properties
    
    private let contentType: SolplyContentType
    private let onTap: (() -> Void)?
    
    private var textColor: Color {
        switch contentType {
        case .place: return .purple700
        case .course: return .green800
        }
    }
    
    private var backgroundColor: Color {
        switch contentType {
        case .place: return .purple300
        case .course: return .green300
        }
    }
    
    // MARK: - Initializer
    
    init(contentType: SolplyContentType, onTap: (() -> Void)? = nil) {
        self.contentType = contentType
        self.onTap = onTap
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 20.adjustedHeight) {
            Text("저장된 \(contentType.title)가 없어요.")
                .applySolplyFont(.body_16_m)
                .foregroundStyle(.gray800)
            
            Button {
                onTap?()
            } label: {
                Text("나만의 \(contentType.title) 수집하러 가기")
                    .foregroundStyle(textColor)
                    .applySolplyFont(.button_16_m)
                    .frame(width: 232.adjustedWidth, height: 64.adjustedHeight)
                    .background(backgroundColor)
                    .capsuleClipped()
            }
            .buttonStyle(.plain)
        }
    }
}
