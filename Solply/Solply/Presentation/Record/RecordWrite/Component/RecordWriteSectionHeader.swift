//
//  RecordWriteSectionHeader.swift
//  Solply
//
//  Created by sun on 3/21/26.
//

import SwiftUI

struct RecordWriteSectionHeader: View {
    
    // MARK: - Properties
    
    let title: String
    var showsGuide: Bool
    var onGuideTapped: (() -> Void)?
    
    // MARK: - Initializer
    
    init(
        title: String,
        showsGuide: Bool = false,
        onGuideTapped: (() -> Void)? = nil
    ) {
        self.title = title
        self.showsGuide = showsGuide
        self.onGuideTapped = onGuideTapped
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 4.adjustedWidth) {
            Text(title)
                .applySolplyFont(.body_14_m)
                .foregroundStyle(.coreBlack)
            
            if showsGuide {
                Button {
                    onGuideTapped?()
                } label: {
                    Image(.infoIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20.adjusted, height: 20.adjusted)
                }
                .buttonStyle(.plain)
            }
            
            Spacer()
        }
    }
}
