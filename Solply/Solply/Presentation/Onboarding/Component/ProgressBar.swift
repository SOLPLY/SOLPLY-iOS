//
//  ProgressBar.swift
//  Solply
//
//  Created by 선영주 on 7/8/25.
//

import SwiftUI

struct ProgressBar: View {
    @State private var rectangleSize: CGSize = .zero
    var step: OnboardingStep
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading){
                Rectangle()
                    .foregroundColor(.gray200)
                    .capsuleClipped()
                
                Rectangle()
                    .sizeState(size: $rectangleSize)
                    .frame(width: geometry.size.width * 0.95)
                    .foregroundColor(.clear)
                    .capsuleClipped()
                
                Rectangle()
                    .frame(width: progressWidth(totalWidth: rectangleSize.width))
                    .foregroundStyle(.gray900)
                    .capsuleClipped()
            }
        }
        .frame(height: 10.adjustedWidth)
    }
}

// MARK: - Functions

extension ProgressBar {
    private func progressWidth(totalWidth: CGFloat) -> CGFloat {
        let totalSteps = Double(OnboardingStep.allCases.count)
        let currentStep = Double(step.rawValue + 1)
        let progress = currentStep / totalSteps
        
        return totalWidth * progress
    }
}
