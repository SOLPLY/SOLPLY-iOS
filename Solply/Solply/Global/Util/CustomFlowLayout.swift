//
//  CustomFlowLayout.swift
//  Solply
//
//  Created by 김승원 on 10/11/25.
//

import SwiftUI

struct CustomFlowLayout: Layout {
    
    // MARK: - Properties
    
    private let horizontalSpacing: CGFloat
    private let verticalSpacing: CGFloat
    private let lineHeight: CGFloat
    private let alignment: HorizontalAlignment
    
    // MARK: - Initializer
    
    init(
        horizontalSpacing: CGFloat,
        verticalSpacing: CGFloat,
        lineHeight: CGFloat = 40.adjustedHeight,
        alignment: HorizontalAlignment = .leading
    ) {
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.lineHeight = lineHeight
        self.alignment = alignment
    }
    
    // MARK: - Functions

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard !subviews.isEmpty else { return .zero }

        let containerWidth = proposal.width ?? 0
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
        var currentY: CGFloat = bounds.minY
        
        // 한 줄씩 묶어서 처리
        var lines: [[LayoutSubviews.Element]] = []
        var currentLine: [LayoutSubviews.Element] = []
        var currentX: CGFloat = 0
        
        for subview in subviews {
            let idealSize = subview.sizeThatFits(.unspecified)
            
            if currentX + idealSize.width > containerWidth + horizontalSpacing && !currentLine.isEmpty {
                lines.append(currentLine)
                currentLine = []
                currentX = 0
            }
            
            currentLine.append(subview)
            currentX += idealSize.width + horizontalSpacing
        }
        
        if !currentLine.isEmpty {
            lines.append(currentLine)
        }
        
        // 줄별로 정렬해서 배치
        for line in lines {
            let lineWidth = line.reduce(0) { $0 + $1.sizeThatFits(.unspecified).width } + CGFloat(line.count - 1) * horizontalSpacing
            
            let startX: CGFloat
            switch alignment {
            case .center:
                startX = bounds.minX + (containerWidth - lineWidth) / 2
            default:
                startX = bounds.minX
            }
            
            var currentX = startX
            
            for subview in line {
                let idealSize = subview.sizeThatFits(.unspecified)
                
                subview.place(
                    at: CGPoint(x: currentX, y: currentY),
                    anchor: .topLeading,
                    proposal: ProposedViewSize(width: idealSize.width, height: lineHeight)
                )
                
                currentX += idealSize.width + horizontalSpacing
            }
            
            currentY += lineHeight + verticalSpacing
        }
    }
}
