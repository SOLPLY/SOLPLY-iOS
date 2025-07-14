//
//  ArchiveButton.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import SwiftUI

/// 탭바 오른쪽에 위치하는 수집함 버튼입니다.
struct ArchiveButton: View {
    
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
            ZStack(alignment: .center) {
                Circle()
                    .frame(width: 60.adjustedWidth, height: 60.adjustedHeight)
                    .foregroundStyle(.gray900)
                
                Image(.collectionIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .renderingMode(.template)
                    .frame(width: 36.adjustedWidth, height: 36.adjustedHeight)
                    .foregroundStyle(.green100)
            }
        }
        .buttonStyle(.plain)
    }
}
