//
//  TextWithBulletIcon.swift
//  Solply
//
//  Created by 김승원 on 3/13/26.
//

import SwiftUI

struct TextWithBulletIcon: View {
    
    // MARK: - Properties
    
    private let text: String
    
    // MARK: - Initializer
    
    init(text: String) {
        self.text = text
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Image(.bulletIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 21.adjusted, height: 21.adjusted)
            
            Text(text)
                .applySolplyFont(.body_14_m)
                .foregroundStyle(.gray900)
        }
    }
}
