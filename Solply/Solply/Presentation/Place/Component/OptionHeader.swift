//
//  OptionHeader.swift
//  Solply
//
//  Created by seozero on 7/15/25.
//

import SwiftUI

struct OptionHeader: View {
    
    // MARK: - Properties
    
    @Binding var isPresented: Bool
    
    private let title: String
    private let isButtonVisible: Bool
    
    // MARK: - Initializer
    
    init(
        isPresented: Binding<Bool>,
        title: String,
        isButtonVisible: Bool
    ) {
        self._isPresented = isPresented
        self.title = title
        self.isButtonVisible = isButtonVisible
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(title)
                .applySolplyFont(.title_18_sb)
            
            Spacer()
            
            Button {
                isPresented = false
            } label: {
                Image(.xIconSm)
                    .resizable()
                    .frame(width: 24.adjustedWidth, height: 24.adjustedHeight)
                    .buttonStyle(.plain)
            }
            .visible(isButtonVisible ? true : false)
        }
    }
}
