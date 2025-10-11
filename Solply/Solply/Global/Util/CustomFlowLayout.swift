//
//  CustomFlowLayout.swift
//  Solply
//
//  Created by 김승원 on 10/11/25.
//

import SwiftUI

struct CustomFlowLayout: Layout {
    private let horizontalSpacing: CGFloat
    private let verticalSpacing: CGFloat
    
    init(horizontalSpacing: CGFloat, verticalSpacing: CGFloat) {
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard !subviews.isEmpty else { return .zero }

        let containerWidth = proposal.width ?? 0
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var lineHeight: CGFloat = 0
        var totalHeight: CGFloat = 0

        for subview in subviews {
            let idealSize = subview.sizeThatFits(.unspecified)

            if currentX + idealSize.width > containerWidth && currentX != 0 {
                currentX = 0
                currentY += lineHeight + verticalSpacing
                totalHeight += lineHeight + verticalSpacing
                lineHeight = 0
            }

            currentX += idealSize.width
            lineHeight = max(lineHeight, idealSize.height)

            if subview != subviews.last {
                currentX += horizontalSpacing
            }
        }
        totalHeight += lineHeight

        return CGSize(width: containerWidth, height: totalHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let containerWidth = bounds.width
        var currentX: CGFloat = bounds.minX
        var currentY: CGFloat = bounds.minY
        var lineHeight: CGFloat = 0

        for subview in subviews {
            let idealSize = subview.sizeThatFits(.unspecified)

            if currentX + idealSize.width > containerWidth && currentX != bounds.minX {
                currentX = bounds.minX
                currentY += lineHeight + verticalSpacing
                lineHeight = 0
            }

            subview.place(
                at: CGPoint(x: currentX, y: currentY),
                anchor: .topLeading,
                proposal: ProposedViewSize(idealSize)
            )
            
            currentX += idealSize.width
            lineHeight = max(lineHeight, idealSize.height)

            if subview != subviews.last {
                currentX += horizontalSpacing
            }
        }
    }
}
