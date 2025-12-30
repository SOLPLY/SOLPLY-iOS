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
            
        // MARK: - TodayPlaceRecommendCarouselLoading
            
        case .todayPlaceRecommendCarouselLoading:
            self.modifier(
                CustomLoadingModifier(
                    loadingType: loadingType,
                    isLoading: isLoading,
                    loadingView: {
                        HStack(alignment: .center, spacing: 16.adjustedWidth) {
                            SolplySkeletonView(width: 180.adjusted, height: 180.adjusted, cornerRadius: 20)
                            SolplySkeletonView(width: 240.adjusted, height: 240.adjusted, cornerRadius: 20)
                            SolplySkeletonView(width: 180.adjusted, height: 180.adjusted, cornerRadius: 20)
                        }
                        .frame(width: 375.adjustedWidth)
                        .clipped()
                    }
                )
            )
            
        // MARK: - PlaceRecommendGridLoading
            
        case .placeRecommendGridLoading:
            self.modifier(
                CustomLoadingModifier(
                    loadingType: loadingType,
                    isLoading: isLoading,
                    loadingView: {
                        Grid(
                            alignment: .center,
                            horizontalSpacing: 12.5.adjusted,
                            verticalSpacing: 16.adjusted
                        ) {
                            ForEach(0..<2) { _ in
                                GridRow(alignment: .center) {
                                    ForEach(0..<2) { _ in
                                        VStack(alignment: .leading, spacing: 8.adjusted) {
                                            SolplySkeletonView(
                                                width: 145.adjusted,
                                                height: 145.adjusted,
                                                cornerRadius: 20
                                            )
                                            
                                            SolplySkeletonView(font: .body_14_m, width: 110.adjusted)
                                        }
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                )
            )
            
        // MARK: - CourseRecommendGridLoading
            
        case .courseRecommendGridLoading:
            self.modifier(
                CustomLoadingModifier(
                    loadingType: loadingType,
                    isLoading: isLoading,
                    loadingView: {
                        Grid(
                            alignment: .center,
                            horizontalSpacing: 12.adjusted,
                            verticalSpacing: 16.adjusted
                        ) {
                            ForEach(0..<3) { _ in
                                GridRow(alignment: .center) {
                                    ForEach(0..<2) { _ in
                                        SolplySkeletonView(
                                            width: 165.adjusted,
                                            height: 165.adjusted,
                                            cornerRadius: 20
                                        )
                                    }
                                }
                            }
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
            .courseRecommendGridLoading,
            isLoading: true
        )
}
