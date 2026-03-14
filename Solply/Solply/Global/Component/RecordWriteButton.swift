//
//  RecordWriteButton.swift
//  Solply
//
//  Created by 김승원 on 3/13/26.
//

import SwiftUI

struct RecordWriteButton: View {
    
    // MARK: - Properties
    
    private let onTap: (() -> Void)?
    
    // MARK: - Initializer
    
    init(onTap: (() -> Void)? = nil) {
        self.onTap = onTap
    }
    
    // MARK: - Body
    
    var body: some View {
        Button {
            onTap?()
        } label: {
            HStack(alignment: .center, spacing: 4.adjustedWidth) {
                Image(.editingIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24.adjusted, height: 24.adjusted)
                
                Text("이 장소에 혼자 다녀왔어요")
                    .applySolplyFont(.button_14_m)
                    .foregroundStyle(.coreWhite)
            }
            .frame(width: 343.adjustedWidth, height: 52.adjustedHeight)
            .background(.gray900)
            .cornerRadius(12, corners: .allCorners)
        }
        .buttonStyle(.plain)
    }
}
