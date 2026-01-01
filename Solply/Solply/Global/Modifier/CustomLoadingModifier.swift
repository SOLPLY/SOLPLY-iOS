//
//  CustomLoadingModifier.swift
//  Solply
//
//  Created by 김승원 on 12/29/25.
//

import SwiftUI

struct CustomLoadingModifier<T>: ViewModifier where T: View {
    
    // MARK: - Properties
    
    private var isLoading: Bool
    private let loadingView: (() -> T)?
    
    // MARK: - Initializer
    
    init(
        isLoading: Bool,
        loadingView: (() -> T)? = nil
    ) {
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
            
        // MARK: - PlaceDetailLoading
            
        case .placeInformationLoading:
            self.modifier(
                CustomLoadingModifier(
                    isLoading: isLoading,
                    loadingView: {
                        VStack(alignment: .leading, spacing: 20.adjustedHeight) {
                            VStack(alignment: .leading, spacing: 10.5.adjustedHeight) {
                                SolplySkeletonView(font: .title_18_sb, width: 110)
                                SolplySkeletonView(font: .caption_14_r, width: 200, cornerRadius: 4)
                            }
                            
                            HStack(alignment: .center,spacing: 8.adjustedWidth) {
                                SolplySkeletonView(
                                    width: 85.adjustedWidth,
                                    height: 40.adjustedHeight,
                                    cornerRadius: 20
                                )
                                SolplySkeletonView(
                                    width: 112.adjustedWidth,
                                    height: 40.adjustedHeight,
                                    cornerRadius: 20
                                )
                            }
                            
                            HStack(alignment: .center, spacing: 12.adjustedWidth) {
                                ForEach(0..<2) { _ in
                                    SolplySkeletonView(
                                        width: 307.adjustedWidth,
                                        height: 204.adjustedHeight,
                                        cornerRadius: 12
                                    )
                                }
                            }
                        }
                        .padding(.leading, 16.adjustedWidth)
                        .frame(width: 375.adjustedWidth, alignment: .leading)
                        .clipped()
                    }
                )
            )
            
        // MARK: - CourseDetailLoading
            
        case .courseDetailLoading:
            self.modifier(
                CustomLoadingModifier(
                    isLoading: isLoading,
                    loadingView: {
                        VStack(alignment: .leading, spacing: 20.adjustedHeight) {
                            VStack(alignment: .leading, spacing: 8.adjustedHeight) {
                                SolplySkeletonView(font: .display_20_sb, width: 183)
                                SolplySkeletonView(font: .caption_14_r, width: 270, cornerRadius: 4)
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                ForEach(0..<4) { _ in
                                    HStack(alignment: .center, spacing: 17.adjusted) {
                                        SolplySkeletonView(
                                            width: 20.adjusted,
                                            height: 20.adjusted,
                                            cornerRadius: 6
                                        )
                                        
                                        HStack(alignment: .top, spacing: 8.adjusted) {
                                            SolplySkeletonView(
                                                width: 52.adjusted,
                                                height: 52.adjusted,
                                                cornerRadius: 12
                                            )
                                            
                                            VStack(alignment: .leading, spacing: 4.adjusted) {
                                                SolplySkeletonView(font: .title_15_m, width: 100.adjusted)
                                                SolplySkeletonView(
                                                    font: .title_15_m,
                                                    width: 165.adjusted,
                                                    cornerRadius: 4
                                                )
                                            }
                                        }
                                        .padding(8.adjusted)
                                        .frame(width: 300.adjusted, height: 68.adjusted, alignment: .leading)
                                        .addBorder(
                                            .roundedRectangle(cornerRadius: 20),
                                            borderColor: .gray300,
                                            borderWidth: 1
                                        )
                                        .background(.coreWhite)
                                    }
                                }
                            }
                        }
                    }
                )
            )
            
        // MARK: - ArchiveLoading
            
        case .archiveFolderLoading:
            self.modifier(
                CustomLoadingModifier(
                    isLoading: isLoading,
                    loadingView: {
                        ScrollView(.vertical) {
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
                                                    width: 165.adjusted,
                                                    height: 165.adjusted,
                                                    cornerRadius: 20
                                                )
                                                
                                                SolplySkeletonView(font: .title_15_m, width: 100.adjusted)
                                            }
                                        }
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 16.adjustedHeight)
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
            .courseDetailLoading,
            isLoading: true
        )
}
