//
//  MyPageButton.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import SwiftUI

/// 탭바 오른쪽에 위치하는 수집함 버튼입니다.
struct MyPageButton: View {
    
    // MARK: - Properties
    
    private let onTap: (() -> Void)?
    
    // MARK: - Initializer
    
    init(onTap: (() -> Void)?) {
        self.onTap = onTap
    }
    
    // MARK: - Body
    
    var body: some View {
        Button {
            onTap?()
        } label: {
            Image(systemName: "house.fill")
                .aspectRatio(contentMode: .fit)
                .frame(width: 50.adjustedWidth, height: 50.adjustedHeight)
                .background(Color(.systemGray5))
                .circleClipped()
        }
        .buttonStyle(.plain)
    }
}
