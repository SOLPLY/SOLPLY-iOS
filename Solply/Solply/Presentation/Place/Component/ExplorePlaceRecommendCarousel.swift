//
//  ExplorePlaceRecommendCarousel.swift
//  Solply
//
//  Created by 김승원 on 1/12/26.
//

import SwiftUI

struct ExplorePlaceRecommendCarousel: View {
    
    // MARK: - Properties
    
    private var onTap: (() -> Void)?
    
    // MARK: - Initializer
    
    init(onTap: (() -> Void)? = nil) {
        self.onTap = onTap
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack(alignment: .center) {
            blurredCarousel
            
            loginButton
        }
    }
}

// MARK: - Subviews

extension ExplorePlaceRecommendCarousel {
    private var blurredCarousel: some View {
        HStack(alignment: .center, spacing: 16.adjustedWidth) {
            carouselCard
                .frame(width: 180.adjusted, height: 180.adjusted)
            
            carouselCard
                .frame(width: 240.adjusted, height: 240.adjusted)
            
            carouselCard
                .frame(width: 180.adjusted, height: 180.adjusted)
        }
        .frame(width: 375.adjustedWidth)
        .clipped()
        .blur(radius: 10)
    }
    
    private var carouselCard: some View {
        Image(.temp)
            .resizable()
            .overlay {
                Color.coreWhite
                    .opacity(0.7)
            }
            .cornerRadius(20, corners: .allCorners)
    }
    
    private var loginButton: some View {
        SolplyMainButton(title: "로그인하고 추천 받기") {
            onTap?()
        }
        .frame(width: 200.adjustedWidth)
    }
}

#Preview {
    ExplorePlaceRecommendCarousel()
}
