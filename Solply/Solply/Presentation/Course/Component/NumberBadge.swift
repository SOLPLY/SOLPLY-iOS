//
//  NumberBadge.swift
//  Solply
//
//  Created by 김승원 on 7/9/25.
//

import SwiftUI

struct NumberBadge: View {
    
    // MARK: - Properties
    
    private let number: Int
    private var isFocused: Bool = false
    
    // MARK: - Initializer
    
    init(number: Int, isFocused: Bool) {
        self.number = number
        self.isFocused = isFocused
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 20.adjustedWidth, height: 20.adjustedHeight)
                .foregroundStyle(.gray200)
            
            Text("\(number)")
                .applySolplyFont(.caption_12_m)
        }
        .frame(height: isFocused ? 104.adjustedHeight : 68.adjustedHeight)
        
    }
}
