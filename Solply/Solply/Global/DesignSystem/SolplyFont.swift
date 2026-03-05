//
//  SolplyFont.swift
//  Solply
//
//  Created by 김승원 on 7/3/25.
//

import SwiftUI

enum SolplyFont {
    case display_24_sb
    case display_20_sb
    case display_16_sb
    case display_12_r
    
    case title_18_sb
    case title_15_m
    case title_14_m
    
    case body_16_m
    case body_16_r
    case body_14_m
    case body_14_r
    
    case head_16_m
    case head_15_sb
    case head_15_m
    
    case button_16_m
    case button_14_m
    case button_14_r
    case button_12_m
    
    case caption_14_m
    case caption_14_r
    case caption_12_m
    case caption_12_r
    case caption_10_m
    case caption_10_r
    
    // MARK: - Font Size
    
    private static let scaleRatio: CGFloat = max(1.adjustedHeight, 1.adjustedWidth)
    
    private var defaultSize: CGFloat {
        switch self {
        case .display_24_sb: return 24
        case .display_20_sb: return 20
        case .display_16_sb: return 16
        case .display_12_r: return 12
        case .title_18_sb: return 18
        case .title_15_m: return 15
        case .title_14_m: return 14
        case .body_16_m: return 16
        case .body_16_r: return 16
        case .body_14_m: return 14
        case .body_14_r: return 14
        case .head_16_m: return 16
        case .head_15_sb: return 15
        case .head_15_m: return 15
        case .button_16_m: return 16
        case .button_14_m: return 14
        case .button_14_r: return 14
        case .button_12_m: return 12
        case .caption_14_m: return 14
        case .caption_14_r: return 14
        case .caption_12_m: return 12
        case .caption_12_r: return 12
        case .caption_10_m: return 10
        case .caption_10_r: return 10
        }
    }
    
    var adjustedSize: CGFloat {
        return defaultSize * SolplyFont.scaleRatio
    }
    
    // MARK: - Letter Spacing
    
    var letterSpacing: CGFloat {
        switch self {
        default: return CGFloat(-0) / 100 * adjustedSize
        }
    }
    
    // MARK: - Line Height
    
    var lineHeight: CGFloat {
        switch self {
        case .display_24_sb: return 36
        case .display_20_sb: return 30
        case .display_16_sb: return 21
        case .display_12_r: return 16
        case .title_18_sb: return 23
        case .title_15_m: return 19
        case .title_14_m: return 18
        case .body_16_m: return 24
        case .body_16_r: return 24
        case .body_14_m: return 21
        case .body_14_r: return 21
        case .head_16_m: return 21
        case .head_15_sb: return 19
        case .head_15_m: return 19
        case .button_16_m: return 21
        case .button_14_m: return 18
        case .button_14_r: return 18
        case .button_12_m: return 16
        case .caption_14_m: return 21
        case .caption_14_r: return 21
        case .caption_12_m: return 18
        case .caption_12_r: return 18
        case .caption_10_m: return 15
        case .caption_10_r: return 15
        }
    }
    
    // MARK: - Font Weight
    
    private var fontWeight: String {
        switch self {
        case .display_24_sb, .display_20_sb, .display_16_sb, .title_18_sb, .head_15_sb:
            return "Pretendard-SemiBold"
        case .display_12_r, .body_16_r, .body_14_r, .button_14_r, .caption_14_r, .caption_12_r, .caption_10_r:
            return "Pretendard-Regular"
        case .title_15_m, .title_14_m, .body_16_m, .body_14_m,.head_16_m, .head_15_m,.button_16_m, .button_14_m, .button_12_m, .caption_14_m, .caption_12_m, .caption_10_m:
            return "Pretendard-Medium"
        }
    }
    
    // MARK: - UIFont Guide
    
    func uiFontGuide() -> UIFont {
        switch self {
        default: return UIFont(name: self.fontWeight, size: self.adjustedSize)!
        }
    }
}

// MARK: - SolplyFontModifier

struct FontWithLineHeight: ViewModifier {
    let uiFont: UIFont
    let targetLineHeight: CGFloat
    let letterSpacing: CGFloat

    func body(content: Content) -> some View {
        content
            .font(Font(uiFont))
            .lineSpacing(targetLineHeight - uiFont.lineHeight)
            .kerning(letterSpacing)
            .padding(.vertical, (targetLineHeight - uiFont.lineHeight) / 2)
    }
}

extension View {
    func applySolplyFont(_ font: SolplyFont) -> some View {
        modifier(
            FontWithLineHeight(
                uiFont: font.uiFontGuide(),
                targetLineHeight: font.lineHeight,
                letterSpacing: font.letterSpacing
            )
        )
    }
}
