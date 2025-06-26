//
//  RoundedCorner.swift
//  Solply
//
//  Created by 김승원 on 6/27/25.
//

import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(
                width: radius,
                height: radius
            )
        )
        
        return Path(path.cgPath)
    }
}

extension View {
    /// 지정된 뷰에 둥근 모서리를 적용합니다.
    /// - Parameters:
    ///   - radius: 적용할 둥근 모서리의 반지름 값입니다.
    ///   - corners: 둥글게 만들 모서리를 지정합니다. (예: .allCorners, [.bottomLeft, .bottomRight])
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    /// 뷰 전체를 캡슐 형태로 자릅니다.
    func capsuleClipped() -> some View {
        self.clipShape(Capsule())
    }
}
