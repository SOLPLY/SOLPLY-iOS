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
            
        // MARK: - SearchLoading
            
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
            
        // MARK: - JGDButtonLoading
            
        case .JGDButtonLoading:
            self.modifier(
                CustomLoadingModifier(
                    loadingType: loadingType,
                    isLoading: isLoading,
                    loadingView: {
                        SolplySkeletonView(font: .body_16_m, width: 42.adjustedWidth)
                    }
                )
            )
            
        // MARK: - RecommendTitleLoading
            
        case .recommendTitleLoading:
            self.modifier(
                CustomLoadingModifier(
                    loadingType: loadingType,
                    isLoading: isLoading,
                    loadingView: {
                        VStack(alignment: .leading, spacing: 0) {
                            SolplySkeletonView(font: .display_20_sb, width: 150.adjustedWidth)
                            SolplySkeletonView(font: .display_20_sb, width: 300.adjustedWidth)
                        }
                    }
                )
            )
        }
    }
}

#Preview {
    Text("dasdf")
        .customLoading(
            .recommendTitleLoading,
            isLoading: true
        )
}
