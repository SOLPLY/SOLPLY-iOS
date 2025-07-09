//
//  ProgressBar.swift
//  Solply
//
//  Created by 선영주 on 7/8/25.
//

import SwiftUI

struct ProgressBar: View {
    var step: OnboardingStep
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading){
                Rectangle()
                    .foregroundColor(.gray200)
                    .capsuleClipped()
                
                Rectangle()
                    .frame(width: geometry.size.width * 0.90 * CGFloat(step.rawValue + 1) * 0.3)
                    .foregroundStyle(.gray900)
                    .capsuleClipped()
            }
        }
        .frame(height: 10.adjustedWidth)
    }
}
