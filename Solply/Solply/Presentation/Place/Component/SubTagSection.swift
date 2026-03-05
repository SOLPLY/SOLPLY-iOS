//
//  SubTagSection.swift
//  Solply
//
//  Created by seozero on 7/16/25.
//

import SwiftUI

struct SubTagSection: View {
    
    // MARK: - Properties
    
    @Binding var isPresented: Bool
    @Binding var tags: [SelectableSubTag]

    private let title: String
    private let isButtonVisible: Bool
    
    // MARK: - Initializer
    
    init(
        isPresented: Binding<Bool>,
        tags: Binding<[SelectableSubTag]>,
        title: String,
        isButtonVisible: Bool
    ) {
        self._isPresented = isPresented
        self._tags = tags
        self.title = title
        self.isButtonVisible = isButtonVisible
    }
    
    // MARK: - Body
    
    var body: some View {
        if !tags.isEmpty {
            VStack(alignment: .center, spacing: 20.adjustedHeight) {
                SubTagHeader(
                    isPresented: $isPresented,
                    title: title,
                    isButtonVisible: isButtonVisible
                )
                
                ChipButtonsContainerView(tags: $tags)
            }
        }
    }
}
