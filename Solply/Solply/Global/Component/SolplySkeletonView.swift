//
//  SolplySkeletonView.swift
//  Solply
//
//  Created by 김승원 on 12/30/25.
//

import SwiftUI

struct SolplySkeletonView: View {
    
    // MARK: - Properties
    
    @State private var isAnimating: Bool = false
    
    private let baseColor: Color = .gray200
    private let gradientColor: Color = .gray300
    
    private var font: SolplyFont? = nil
    private var height: CGFloat = 0
    private let width: CGFloat
    private let cornerRadius: CGFloat
    
    private var contentHeight: CGFloat {
        font?.adjustedSize ?? height
    }

    private var containerHeight: CGFloat {
        font?.lineHeight ?? height
    }
    
    // MARK: - Init
    
    init(
        width: CGFloat,
        height: CGFloat,
        cornerRadius: CGFloat
    ) {
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
    }
    
    init(
        font: SolplyFont,
        width: CGFloat,
        cornerRadius: CGFloat = 5
    ) {
        self.font = font
        self.width = width
        self.cornerRadius = cornerRadius
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(baseColor)
                .overlay {
                    shimmerLayer
                }
                
                .cornerRadius(cornerRadius, corners: .allCorners)
                .frame(height: contentHeight)
                .onAppear {
                    isAnimating = true
                }
        }
        .frame(width: width, height: containerHeight)
    }
}

// MARK: - SubViews

extension SolplySkeletonView {
    private var shimmerLayer: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                gradientColor.opacity(0.0),
                gradientColor.opacity(0.5),
                gradientColor.opacity(0.0)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
        .offset(x: isAnimating ? width * 2 : -width * 2)
        .animation(
            .linear(duration: 1.75)
            .repeatForever(autoreverses: false),
            value: isAnimating
        )
    }
}

#Preview {
    SolplySkeletonView(width: 100.adjustedWidth, height: 20.adjustedHeight, cornerRadius: 5)
    SolplySkeletonView(width: 240.adjusted, height: 240.adjusted, cornerRadius: 20)
    
    VStack(alignment: .leading, spacing: 0) {
        SolplySkeletonView(font: .display_20_sb, width: 300.adjustedWidth, cornerRadius: 5)
        SolplySkeletonView(font: .display_20_sb, width: 300.adjustedWidth, cornerRadius: 5)
    }
}
