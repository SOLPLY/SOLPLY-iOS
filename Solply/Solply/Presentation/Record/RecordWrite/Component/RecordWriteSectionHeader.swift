//
//  RecordWriteSectionHeader.swift
//  Solply
//
//  Created by sun on 3/21/26.
//

import SwiftUI

struct RecordWriteSectionHeader: View {
    let title: String
    var showsInfo: Bool = false
    var onInfoTapped: (() -> Void)? = nil
    
    var body: some View {
        HStack(alignment: .center, spacing: 4.adjustedWidth) {
            Text(title)
                .applySolplyFont(.body_14_m)
                .foregroundStyle(.coreBlack)
            
            if showsInfo {
                Button {
                    onInfoTapped?()
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


