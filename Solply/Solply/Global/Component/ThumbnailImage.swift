//
//  ThumbnailImage.swift
//  Solply
//
//  Created by 김승원 on 2/26/26.
//

import SwiftUI

import Kingfisher

struct ThumbnailImage: View {
    
    // MARK: - Properties
    
    private let thumbnailImageUrl: String?
    private let width: CGFloat
    private let height: CGFloat
    private let radius: CGFloat
    
    // MARK: - Initializer
    
    init(
        _ thumbnailImageUrl: String?,
        width: CGFloat,
        height: CGFloat,
        radius: CGFloat = 20
    ) {
        self.thumbnailImageUrl = thumbnailImageUrl
        self.width = width
        self.height = height
        self.radius = radius
    }
    
    // MARK: - Body
    
    var body: some View {
        Group {
            if let thumbnailImageUrl {
                KFImage(URL(string: thumbnailImageUrl))
                    .placeholder {
                        Image(.placePlaceholder)
                            .resizable()
                    }
                    .resizable()
            } else {
                Image(.placePlaceholder)
                    .resizable()
            }
        }
        .aspectRatio(contentMode: .fill)
        .frame(width: width, height: height)
        .cornerRadius(radius, corners: .allCorners)
    }
}
