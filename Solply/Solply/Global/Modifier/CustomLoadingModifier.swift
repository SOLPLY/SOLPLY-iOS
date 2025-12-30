//
//  CustomLoadingModifier.swift
//  Solply
//
//  Created by 김승원 on 12/29/25.
//

import SwiftUI

struct CustomLoadingModifier<T>: ViewModifier where T: View {
    
    // MARK: - Properties
    
    private var loadingType: CustomLoadingType
    private var isLoading: Bool
    private let loadingView: (() -> T)?
    
    // MARK: - Initializer
    
    init(
        loadingType: CustomLoadingType,
        isLoading: Bool,
        loadingView: (() -> T)? = nil
    ) {
        self.loadingType = loadingType
        self.isLoading = isLoading
        self.loadingView = loadingView
        
    }
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        Group {
            if isLoading {
                self.loadingView?()
            } else {
                content
            }
        }
    }
}

// MARK: - View

extension View {
    @ViewBuilder
    func customLoading(_ loadingType: CustomLoadingType, isLoading: Bool) -> some View {
        switch loadingType {
        case .searchLoading:
            self.modifier(
                CustomLoadingModifier(
                    loadingType: loadingType,
                    isLoading: isLoading,
                    loadingView: {
                        ProgressView()
                            .tint(.gray800)
                            .progressViewStyle(.circular)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50.adjustedHeight)
                            .background(.coreWhite)
                    }
                )
            )
        }
    }
}

#Preview {
    Text("dasdf")
        .customLoading(
            .searchLoading,
            isLoading: true
        )
}
