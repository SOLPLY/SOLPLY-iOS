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
        content
            .opacity(isLoading ? 0 : 1)
            .overlay(alignment: .top) {
                if isLoading {
                    self.loadingView?()
                        .allowsHitTesting(false)
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
            
        // MARK: - JGDLoading
            
        case .JGDLoading:
            self.modifier(
                CustomLoadingModifier(
                    isLoading: isLoading,
                    loadingView: {
                        HStack(alignment: .top, spacing: 0) {
                            VStack(alignment: .center, spacing: 0) {
                                ForEach(0..<3) { index in
                                    SolplySkeletonView(
                                        font: .body_16_r,
                                        width: 42.adjustedWidth
                                    )
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 46.adjustedHeight)
                                    .background(index == 0 ? .coreWhite : .clear)
                                    .overlay(alignment: .bottom) {
                                        Rectangle()
                                            .frame(height: 1)
                                            .foregroundStyle(.gray200)
                                    }
                                }
                            }
                            .frame(maxHeight: .infinity, alignment: .top)
                            .frame(width: 128.adjustedWidth)
                            .background(.gray100)
                            
                            Rectangle()
                                .frame(width: 1)
                                .frame(maxHeight: .infinity)
                                .foregroundStyle(.gray200)
                            
                            VStack(alignment: .center, spacing: 0) {
                                ForEach(0..<5) { _ in
                                    SolplySkeletonView(
                                        font: .body_16_r,
                                        width: 58.adjustedWidth
                                    )
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 16.adjustedWidth)
                                    .frame(height: 46.adjustedHeight)
                                    .overlay(alignment: .bottom) {
                                        Rectangle()
                                            .frame(height: 1)
                                            .foregroundStyle(.gray200)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .overlay(alignment: .top) {
                            Rectangle()
                                .frame(height: 1)
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(.gray300)
                        }
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
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                )
            )
            
        // MARK: - PlaceRecommendLoading
            
        case .placeRecommendLoading:
            self.modifier(
                CustomLoadingModifier(
                    isLoading: isLoading,
                    loadingView: {
                        VStack(alignment: .center, spacing: 28.adjustedHeight) {
                            HStack(alignment: .center, spacing: 16.adjustedWidth) {
                                SolplySkeletonView(width: 180.adjusted, height: 180.adjusted, cornerRadius: 20)
                                SolplySkeletonView(width: 240.adjusted, height: 240.adjusted, cornerRadius: 20)
                                SolplySkeletonView(width: 180.adjusted, height: 180.adjusted, cornerRadius: 20)
                            }
                            .frame(width: 375.adjustedWidth)
                            .clipped()
                            
                            VStack(alignment: .leading, spacing: 16.adjustedWidth) {
                                HStack(alignment: .center, spacing: 0) {
                                    SolplySkeletonView(font: .body_14_m, width: 25.adjustedWidth)
                                    
                                    Image(.arrowDownIcon)
                                        .resizable()
                                        .frame(width: 24.adjusted, height: 24.adjusted)
                                }
                                .padding(.vertical, 4.adjustedHeight)
                                .padding(.leading, 12.adjustedWidth)
                                .padding(.trailing, 4.adjustedWidth)
                                .addBorder(.capsule, borderColor: .gray300, borderWidth: 1)
                                
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
                            .padding(.vertical, 20.adjustedHeight)
                            .padding(.horizontal, 20.adjustedWidth)
                            .background(.coreWhite)
                            .cornerRadius(20, corners: .allCorners)
                        }
                        .frame(width: 343.adjustedWidth)
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
            
        case .placeDetailLoading:
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
                                    width: 73.adjustedWidth,
                                    height: 40.adjustedHeight,
                                    cornerRadius: 20
                                )
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
                        .padding(.top, 16.adjustedHeight)
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
            
            // MARK: - RecordListLoading
            
        case .recordListLoading:
            self.modifier(
                CustomLoadingModifier(
                    isLoading: isLoading,
                    loadingView: {
                        VStack(alignment: .center, spacing: 0) {
                            ForEach(0..<2) { index in
                                VStack(alignment: .leading, spacing : 16.adjustedHeight) {
                                    HStack(alignment: .center, spacing: 8.adjustedWidth) {
                                        SolplySkeletonView(width: 24.adjusted, height: 24.adjusted, cornerRadius: 0)
                                            .capsuleClipped()
                                        
                                        SolplySkeletonView(font: .body_14_m, width: 60.adjustedWidth)
                                    }
                                    
                                    HStack(alignment: .center, spacing: 8.adjustedWidth) {
                                        ForEach(0..<4) { _ in
                                            SolplySkeletonView(width: 72.adjusted, height: 72.adjusted, cornerRadius: 12)
                                        }
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 2.adjustedHeight) {
                                        SolplySkeletonView(font: .body_14_r, width: 343.adjustedWidth)
                                        SolplySkeletonView(font: .body_14_r, width: 343.adjustedWidth)
                                    }
                                    
                                    SolplySkeletonView(font: .body_14_m, width: 127.adjustedWidth)
                                }
                                .padding(.vertical, 20.adjustedHeight)
                                .overlay(alignment: .bottom) {
                                    if index == 0 {
                                        Rectangle()
                                            .frame(height: 1)
                                            .foregroundStyle(.gray300)
                                    }
                                }
                                .padding(.horizontal, 20.adjustedWidth)
                            }
                        }
                    }
                )
            )
        }
    }
}

#Preview {
    Text("")
        .customLoading(.recordListLoading, isLoading: true)
    Spacer()
}
