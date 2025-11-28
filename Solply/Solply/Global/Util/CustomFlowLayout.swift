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
        let lineHeight: CGFloat = 40.adjusted
        var currentX: CGFloat = 0
        var lineCount: Int = 0

        for subview in subviews {
            let idealSize = subview.sizeThatFits(.unspecified)

            if currentX + idealSize.width > containerWidth && currentX != 0 {
                currentX = 0
                lineCount += 1
            }

            currentX += idealSize.width

            if subview != subviews.last {
                currentX += horizontalSpacing
            }
        }
        
        let totalLines = lineCount + 1
        
        let totalHeight = CGFloat(totalLines) * lineHeight + CGFloat(max(0, totalLines - 1)) * verticalSpacing

        return CGSize(width: containerWidth, height: totalHeight)
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let containerWidth = bounds.width
        let lineHeight: CGFloat = 40.adjusted
        var currentX: CGFloat = bounds.minX
        var currentY: CGFloat = bounds.minY

        for subview in subviews {
            let idealSize = subview.sizeThatFits(.unspecified)

            if currentX + idealSize.width > containerWidth + horizontalSpacing && currentX != bounds.minX {
                currentX = bounds.minX
                currentY += lineHeight + verticalSpacing
            }

            subview.place(
                at: CGPoint(x: currentX, y: currentY),
                anchor: .topLeading,
                proposal: ProposedViewSize(width: idealSize.width, height: lineHeight)
            )

            currentX += idealSize.width

            if subview != subviews.last {
                currentX += horizontalSpacing
            }
        }
    }
}
